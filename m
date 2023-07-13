Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2374B7525CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjGMO5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjGMO5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:57:16 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2133.outbound.protection.outlook.com [40.107.101.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E0D273B;
        Thu, 13 Jul 2023 07:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfR/VIeMtaWYZ4WiXEfBHpXjaS65DhgkbCtQx2HdfLqmagbxnSY4MPxl137AAMiK9hvHW/LUO52H+XG+/QkIucC1nh3YcAXiWu0h8FoGzN6b2fB+9G3qzdg2IQ5kdvEHvFL1y3yCETC9mWZeggmPeEPeGbkUhcDaSn5S7JtIiMfH/mXodwxslQS8yAL7EglAWu4iKjKzNFenX+QuN/47U5Dk5Q/K+qGA39cjnEYFaaqTdTzHiYnUgdERyQ+g6ZwTsFg2aCy0Sdko0sVMoo0qJbC0r029YJmbEveWbs+j79qqAajSDy2qRV5RcAZ7C9YN/ro2S1zG6Qafrq0FXjnK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRSiJT8CaXdqPEne/Y7lKKbzfXLSBw3AEbu6sJ/mMcI=;
 b=oYjKUaT+n3XxoFu55R0efcTMMkmR0axWzA6Iw7GNHe9fzBY610bO2ud2S6eCJxlI1N70C8yTHi7OYgVr7bC5AeQERUTMZdYvXkK0FU20nm/tPMHcNn3nqAK/AZo0RJ/ANiO7RkU3Fhcx25WD7jrc7IJRA4d2lB3M2+xCjK1Gmn/KkJiIdrDfXVQd5IoA6vtlFmJGhCPN4aL6Vu9ihim/F8SjaWZ8U/XQuAjv6p0eB28xU9gh/9APPwXV7ugKwzeCfLzf7oSJaYNAkyVw1IRLEEU26YAJyy42aAHcjuxE1vmTy6v69c8Siy+mXjVCJ+k/R1zpg+chRC1C3JhgNFQMRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRSiJT8CaXdqPEne/Y7lKKbzfXLSBw3AEbu6sJ/mMcI=;
 b=sPcGQUw3yiMDBs5RypUQQ0XNNMw/ibCtseaL2sj2qZRku6wHeJi+6P4vswU7AjVMViIdhiwJVnC7xA542Q6dtQHA+WaOqsjN3Ab42RkuT0py0R/Drd0JpDkTp4FZU7WvMDa6b4jwZgarQyWYtZEKvukGF4KOX5NMqVEP/J2Bvqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO1PR13MB4984.namprd13.prod.outlook.com (2603:10b6:303:f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 14:57:05 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 14:57:05 +0000
Date:   Thu, 13 Jul 2023 15:56:58 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Vignesh Viswanathan <quic_viswanat@quicinc.com>
Cc:     mani@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com, quic_clew@quicinc.com
Subject: Re: [PATCH net-next 3/3] net: qrtr: Handle IPCR control port format
 of older targets
Message-ID: <ZLAQutQn/f32eInE@corigine.com>
References: <20230712112631.3461793-1-quic_viswanat@quicinc.com>
 <20230712112631.3461793-4-quic_viswanat@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712112631.3461793-4-quic_viswanat@quicinc.com>
X-ClientProxiedBy: LO6P123CA0045.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::14) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO1PR13MB4984:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b74ba2-3942-49d6-d67c-08db83b16bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CNyN7MvgfZPPrVUFhDWC/7ohMUb7RNER9euzTKefEHTT6Ug0ajDwPLmH7C82KoR5zdXr3HK0WnCr4AKlWTwJ+G8LMf8XdqGdskOOq5r2K1okD/6CP/4ZJjIN+JcWtrlbpDNiR8xRfmTNFoM4YctcjqjfNObrVyazq2aZ+L2ja+mJV9gWH2y0CayinZEy3iVTH4oTYjgY77EqHj4Aer5QzclFB2KnkWc0xC5Dss6hHM+MYsQFh9TL86eL8puEfTgOwLkEbQo6pdwqaBaKTX4tceaOhaIv8fTUgZTI2UNgLNqz22FxnNvUKRidcWzJ2A2a7Z+/WBiRzfYav2hxrEucXX5BRMo3ySo5qrxbHrvBta4xF6HTgxdsYV9N+NkmLTMwDN29ge2dfBfGNjhbt8vul76RS7zV4IgtHrVgWIZtWDOb9cMi76f7qn/KDzq7CqP3uuRQc0LdNf1nTwOPOGDUlQv8pjL7id7GAb5GbVScQKV3aG2Xw/qwSVJR6wuM8Y31tUqY8DIEiYYWapFX/fr7Dthu+HdsXjE1tRkZB1iM39TLax1FlNArlaTJVPws306rHWSadLwEQcdW44AdQn4EcfOiWsK9IHXEqlZYg4x3Cqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39830400003)(346002)(366004)(451199021)(6666004)(478600001)(6506007)(26005)(2906002)(4744005)(6512007)(6486002)(4326008)(6916009)(66476007)(66556008)(66946007)(316002)(5660300002)(36756003)(2616005)(44832011)(38100700002)(7416002)(41300700001)(8676002)(8936002)(186003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?evBGyloSFzQdd4ZR6b4zZEW4BatYZ9/TDWZpD1WQ728WTeudTN9nZLQoQ4V6?=
 =?us-ascii?Q?ufddqw8dM0NS7Rk/tJiCMn34tKqJOSXPeZnCjTQWF0EQ9V6wwohg3E3nojkr?=
 =?us-ascii?Q?4H2N/syZzvAxfi5N54H6Mc25ZftYLIyzY9vkrKIdnlFowCs0BthERBDt3Bic?=
 =?us-ascii?Q?UsWSLxaN2eDS8Xq9o/2pgET50V9AekeRD1KZs9zN3tFfF5SHikWNpALnB02J?=
 =?us-ascii?Q?WYou0RmMefjjyanSnRQnHz84Zf98OLF32WY0JjVpOYGc+xxM8iAnKiS9+Gey?=
 =?us-ascii?Q?mpOoIdm/WUV2Dc1gyhbEs2dnG9FiU5s81L5wWOGCJxTkGJclgoIrRjACRJ5c?=
 =?us-ascii?Q?QuulEpY04cD9n2rHLMetXltZP41SX4u0aCjsCcO+rIaofuN2Sfe19WiadNaM?=
 =?us-ascii?Q?dXIBIDhuUsZZHKLauQtoldYZBkT+2P/P0UNQISfGRWzUHKEraggxuV5bxe5n?=
 =?us-ascii?Q?gZvvuY/qkmpQnIFBecJDxlKCWJFn3c3wQXGMPhXb1wLc+vuIfqhT7oVlKRwD?=
 =?us-ascii?Q?LR8WCmy0yXyspoXxIblMH6My80O0LrBI8y6GHtQG7etK0vHvsGDocUumN9UK?=
 =?us-ascii?Q?gmGtdJYpwGtfyOSV5cz5F+uR6Bxe1rM2XEZb2y6/15Aq5wMVr3whb8WF6XK0?=
 =?us-ascii?Q?qkxw7yyEGa+gIlRwItSUWYYFK2dZWANdfdbrOM0W/w9cRGUMuHeiC3+wrO9w?=
 =?us-ascii?Q?tKxIWHk6XInMLccEVmVTkj4KmOJRiq1rmXudfC9DCz9k9KZXOqT0mbTIGNrH?=
 =?us-ascii?Q?ZrYhTgiElpKREmEOLpjMYaZTPt6K+BGoBgsQk2SalBeAQJ0CNT4HRS59UcZZ?=
 =?us-ascii?Q?7Sx+pnHGyMhotxY9VuTrRXxhuXyE/IF8zJ28k5uCX8SiypJhjZWbj7ebvT8Y?=
 =?us-ascii?Q?7t3dD+ud9rHF5qbyW2CmVcc0kQFAdASzuvxVh6X6SLy4rZhhNLZYFuC2SEtD?=
 =?us-ascii?Q?s88Xp+NFmvc2nrVaCJT8PxylWD/0Kzf4jl4L8o8JlWMXU4g3rzD3YMMx7+JH?=
 =?us-ascii?Q?SAGRUBwZVyq6ETFhZUEcdRF0EjR/AYpeiEAdJ+bQZSx96w5MZIud3D7LB5HH?=
 =?us-ascii?Q?H8yN2jkmLAnAIk8rTWFaf2Oh9cLOLM//ZxH9aND/fHCN7jFDOFwwRwYbUfx4?=
 =?us-ascii?Q?ZNlZtAc5EO99FEDkTexJdNv5N0Q+GAAT4mCmE6GgprHqOhwByGOFl14UVkpq?=
 =?us-ascii?Q?6mtjMBoWKD9YqT43sIDHUd0NBYf9UbqZeSrDRwxx1aMYlhRszpSlU8P1FHx2?=
 =?us-ascii?Q?TMjUyQXFCeOM+PLratt1YEMNl+wGYJJjnXa1ItRdrsihv+jVUk05kZX+AmER?=
 =?us-ascii?Q?gTvWywQV3RPBU0HWf3ARiua2ORsbOGo79g4v2z9X2bEhFdx9aFyC5R+O1nJk?=
 =?us-ascii?Q?N2wBTU0Enfel5uvO1tHwZrgrpmUkrQuy+iKlfH5qy5dzAD0Ikz399eqyIoNp?=
 =?us-ascii?Q?2wU1f6NPKOdqEV4HZwQ9N7oT2L/bVLCUt6cb2+AXon/zQmY8JOgw4X1SKTba?=
 =?us-ascii?Q?MvH1VbXFyq+5qWEnPtLzbLcy2k0jwpyx7qcM+sFGGs3ZWTItjg2IfRdfrf1Q?=
 =?us-ascii?Q?D4Jms7pT1OmH1yXlCD5cLOLxNUyyZU/bz2r0nWDzxPnJ5G7MhsH0gt9ppoFP?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b74ba2-3942-49d6-d67c-08db83b16bfb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 14:57:04.9512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/aehq1eRpGcD/AiexMV9ByfQHJq0XYkSWba/RvZ/NLo64Rx9/sQxPwXND8pZPMqI4SO/MlvOWb7duC1P+mkHhAzuHlxMV3UbGHFT39RneI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB4984
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 04:56:31PM +0530, Vignesh Viswanathan wrote:
> The destination port value in the IPCR control buffer on older
> targets is 0xFFFF. Handle the same by updating the dst_port to
> QRTR_PORT_CTRL.
> 
> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

