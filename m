Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4974A75DE66
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 22:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjGVUAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 16:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGVUAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 16:00:02 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2132.outbound.protection.outlook.com [40.107.92.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871AA10C3;
        Sat, 22 Jul 2023 13:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+31PJHk1sqd8WOdHuIxHrLfyS7tfvKoAAaxuwHSQkZxR2wtrMFsnF1IAcQzm0o6C+McmyzTn6xeRXGyZQmlLaWFrCWZF6J3gaT4sIFvX4CysrkWYmZ9fDjBouZ9sxTJ/Lm3rFnMlrO+P//XzMWByPibuBmMIo8wegZKoSsm8HKkfXTa5zZ6hbeAkOWdBjZAvE7+sZTBhXwyZywzh3lYBNvKnGHzqcYx4Nss1M3j8J2Iyyn8WR0oQrLY3IKXVzw7t4USkPHuLBmL/5Gg64jR9UKLoZciwldwwoz/wtYRhSNH1vnn1xrYRky0KEgOuuwiGL5yFVeIEGSxUjVOr3YvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57alvt58r9TyS655zMEts/nipV2TAKnN1QkncZJbzeE=;
 b=LD2NcG+YSQkNXUMVhW5Rjuoh/N3JvVV+3Qm2+VI3qoRFgdb6HcxJorvCvqKbDescmO6DvYfzxyWmb08/R++K9ip8YDVwvVpRrDs7DzXPQ9V2ocpMhhofMD1kIxJJekUtYK8KYb48WR6SiqMN04piOKR9NRKCyiM7Q/s/VfK6MS9hZ0Sy/Ywh0xvxBhREMKNiDvjAfJ5w/4u3g3nzqpGcSJreLSzN0XsMt7STT2X9E8WFKURjJJHpPVZDua3QtAQ/Gxmhm5pW5UkOaXnCO7yhJHAZMYq3NrWbJn7OYh79g9KqY6dg3xsMzuPEJJxCHTzncs+leThjwlYNCSfuQJfaRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57alvt58r9TyS655zMEts/nipV2TAKnN1QkncZJbzeE=;
 b=fZGR2o3WVJzvt3KdNjhQj55vbJFN+pNlbbuWDzmI/XAAwp2+xNQlY+233ByEKkPXcV43sDpKzbl9Vx0F1pcaEve37K9TzoWqCKHGCriJqoBr3IZpto9bSdo6sKhapb6cOwL/Vv81hDXEXnZy4tZxgWMnFzymPdlYmu/4DImDeuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB4086.namprd13.prod.outlook.com (2603:10b6:208:26f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sat, 22 Jul
 2023 19:59:56 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.029; Sat, 22 Jul 2023
 19:59:56 +0000
Date:   Sat, 22 Jul 2023 20:59:46 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lcherian@marvell.com,
        jerinj@marvell.com
Subject: Re: [net PATCH V4] octeontx2-af: Fix hash extraction enable
 configuration
Message-ID: <ZLw1MstJYEwAWRoa@corigine.com>
References: <20230721061222.2632521-1-sumang@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721061222.2632521-1-sumang@marvell.com>
X-ClientProxiedBy: LO4P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::14) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b2fdde-062b-404c-e742-08db8aee389d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X5aMxAxajlXU+GcfI0FYN38W9NFmQ5cekabERMrjlmkXedffZR8o76No2c8eHgaF9APwojCcs04UV7x++Td96JsCa2t16vOUp7fkdeiexKiCO/Aywxj3KeaudlDnY/gD5ucOxs2HT7A7b4SYDN0MjqglChvqRqaQ/otEileovDxkRpSCAmDR54Nvwxz2BFuH8lubejrtgcGm44vEH3taVV3ruVtUANrJP3Okm3kiO6U/348yxPVSTXkkb0Ux/agIwP0inBwvDVdm0qzs59mplW+TU5amHrFYIW5Z15ImQOqQrqA4PDcxuFwMVwUVeQAuv3XHYOprvmifoKhR+0HNlqGptS0SW0ExgQZ8quVGgU8gjJUmbJmJI0SUieoBHpmAUoyx5HIj62MxGjurUQOoR+gBgWs/DA8IDVuSSjg1jtLDID+X+tSc5NchMHnf1atuMj/PvH8RPdOSbbCX+7Gr5x+iMiltsH4uvT7BM5PLU13iAQA1yzo3OLuJ8/C+GWoe4p/5aTkMKlw/wfeWrqqVUZMqgsyThwGsJl7N980rBNwe+mq+7mj+KCD4xHa5zXxlslkvXZ5qD0J477DF5RTeCdqwFDQRoWlf33x0dwAMyWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(39830400003)(346002)(451199021)(6486002)(6512007)(478600001)(6666004)(86362001)(4744005)(44832011)(2906002)(2616005)(186003)(55236004)(26005)(6506007)(38100700002)(36756003)(66946007)(66556008)(66476007)(6916009)(4326008)(316002)(41300700001)(8676002)(8936002)(5660300002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6KcJQcxBhayJtLiMkBJa3xd0AqwC7SQm+8xdysXYXyISqOyXFLSJ4TO1C3Zr?=
 =?us-ascii?Q?3Bd/paAM3XwB0W/bRynHGBpfrgioCZOHYvAciqRfZJf77/nIhkWBlSbjX3b6?=
 =?us-ascii?Q?1u2RRgNX3XGy8IQE2AGqjLBX7nMKaP3jNF35Jhrhnnmi7RN5o0kbcWdI7B2e?=
 =?us-ascii?Q?SZUfAZDKwNW5D/5u83uezr8lHS0fY5rdV3gO6dbmQg53Q+1pT8HRNbJHxj3k?=
 =?us-ascii?Q?OMr1c1lCa60Y+u7U1QFTmP6xRuDeKZmX6RhCDWNGV8TxIg+KZxUTyPCLL9Ky?=
 =?us-ascii?Q?hidhdV0+N2RCKLMl9UhwwBTLsgH+w0MZpw5w7qM76utd1rls4rSzVZwRZe2p?=
 =?us-ascii?Q?HaPCe2bw2ql32V1nlMg41DHPe5PrSOEzV+PGwKhdLHbezFLNVOP57jh8+fuy?=
 =?us-ascii?Q?E0fu9oqKR/kEqJpjwQhgosMTzQB69qdTo4t6EHsf0m4gRTXG5auOaRq8XKR2?=
 =?us-ascii?Q?1TKqQVmH70L2W74vNWEFBTNv462Tjkfcb55BzaZhXqsSl+ynh6qvOCH+jFn/?=
 =?us-ascii?Q?GxbOW2xPDTfsU+e86Wr4dBbqslFhZBiRNUBWcUisyOm5RPW4lHGpSuApmEJI?=
 =?us-ascii?Q?CfBHCslb7UVACtGaWeATRosGuU+kkKQnbzMxlhapuYYFhvGrDyKiolwaqxPS?=
 =?us-ascii?Q?2kikF2Gn5WFAK0WUEvk+zhTt+kSsQTK+KYz8mHPS4F5ZpMl96CIju4Kp1Zg8?=
 =?us-ascii?Q?tEsH61s22qGYmgE3WG8utvYziMKMjZIzehSxbzsa5Az52vHu0yDJyktAsA8s?=
 =?us-ascii?Q?LEmDvhSDHIOobtFeNH477dkbzzerUtbRdGminm9ptFzkX+F7iRO+zCkev/Qs?=
 =?us-ascii?Q?NcOAtPpT03vKFExmBG/n5xl4OGtz17BlMzs7EeKi9d2RVsDJ5qZpx4QNoE7M?=
 =?us-ascii?Q?KMHBF8ZKpJUKzjKT9R5pYWtn8sLPK/T7qLfy+oRR2Ap6PIpkUmYOaKx0o+89?=
 =?us-ascii?Q?B7eRytcywiy3qTOWgtSezehZvuYsyxNhQ3ALBjgQNTUb/rhp2KbgatbDrmxZ?=
 =?us-ascii?Q?D8wbjnubrnX1dhLBxP91KkFgxhau081HouGZ9yPGwPHXGojSCyA/WMj1qUsg?=
 =?us-ascii?Q?aMTyOAX9SsJMx1Etn6vC4jcd5KffeHt19LNS3U09KgYnmaEmBjW5QeUWciCQ?=
 =?us-ascii?Q?TY95xaSWRM2E7NRH4fKQpU/rNwgoAJbVDyvfH63ByHpiUYh2rscJZwAgBbh/?=
 =?us-ascii?Q?SdX63rMOLC9lR/CYjwA/k5fvMBghuR7iRR2+l500dk1xkv31sXYjeV35zJbf?=
 =?us-ascii?Q?ivGJXRrscT1vyAX9ybGYxV1A8Ppca+jNy2PlHSmrmjeGC49FJh1/L9h4wG51?=
 =?us-ascii?Q?rd36FGfw6/pvFBRSeUyJdhOUiBglBFhMGj4vISBInGxbcvt7x2S1r6rIng+b?=
 =?us-ascii?Q?JjX3xjRf+tPzq5EvQikZ2W+tgPAGY2MMN8hnaWjpr6l5hUrmDhpWM738i774?=
 =?us-ascii?Q?P1emJHcr9Og5ZASmZjVA45lNhkeyxpAEW0tPL9OjI+0zBbBGkp6OEbrs30uQ?=
 =?us-ascii?Q?TK7jnfuLXtKEIkTkZqsRWnbAYXst4ZohFE7rw/zPPmYVz3z/WjTjtxxrQ6FC?=
 =?us-ascii?Q?zNF4C4PaCPdRt3Pg4sX1U6HrGaTr2zpRVS9ievaAcySzBJFIZ/N9xmeyYkdZ?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b2fdde-062b-404c-e742-08db8aee389d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 19:59:56.3223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CETsqHQqFGCONoVQ5NHrcKnRKf7U01FULPUHH9vQ6SiRhpK120z0e98rR7tQdDoFITG9zuDeZC0Og/zEuT+Obw+1//9uST2fhldi9iQc7WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4086
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 11:42:22AM +0530, Suman Ghosh wrote:
> As of today, hash extraction support is enabled for all the silicons.
> Because of which we are facing initialization issues when the silicon
> does not support hash extraction. During creation of the hardware
> parsing table for IPv6 address, we need to consider if hash extraction
> is enabled then extract only 32 bit, otherwise 128 bit needs to be
> extracted. This patch fixes the issue and configures the hardware parser
> based on the availability of the feature.
> 
> Fixes: a95ab93550d3 ("octeontx2-af: Use hashed field in MCAM key")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

