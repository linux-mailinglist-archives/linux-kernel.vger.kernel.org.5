Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15707D010C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346247AbjJSR7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjJSR7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:59:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12F3E8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LztAXkraogPVFx9+aV0ZpGGUAM8v4stVaTLl6g/pSDGzpagXRS4aDKtrXnCxRsq/i03OQ+5yfvgo+wcEi/6NarcS7YnVgx0ZAoQIerFWLh5XNrUTwLOHqiF/c+WiFSTLEhRnpfciBFTJJORDQXHqDqQXZI8hf3lmaHidhHDQPxVF1MIOwPMsJcTL7b1kgOW0/Ar6PNr3R1WzMPUR9IAqYN9Y0kFLBycispZhFMrYv9imc7uAbhQP83moyLlhi45F3OlyMpJ/vsYPgbmqYZvHN9x94uAcn4jYnqGdQMaFBEPJTuHg2I1T4E2rSQRdgKPo5OFMztHL4iba5z5YIDAX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNf/0NubxBMXjbfE2EIgKOXUndD5ElNt9Ew352KodkY=;
 b=DmVnO0tVUHdasqjWijvDlDNjITX9wWKGWN9fLKZD4qVG6L73GBAIEA/iNhKSQDFqJznZnLcnGXlh8uOwBtRC8JlzZ0OOxRC6/LuUfX8pa1EI8vtkMA1G58DrIlBW0rdj4BSComUWzLr1WopEIhVpRDg4h0gLfShSFSb6ZaHsFxyLE18uZcwZtzYD8U/9FmsEtFka0hL1yJ8zeAOwXcjKrJC15xaMfn10zQO01nfkTfQvDR45YRG9PP29/yspnmQZ+39ISICQJ0ByM1LWXgmGx/ncLkKv83Plw6WeT9dQyCBrvAD7xWeuoDpYk4P7jRLvf0tCZKIGA2QZdVnc3M+ELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNf/0NubxBMXjbfE2EIgKOXUndD5ElNt9Ew352KodkY=;
 b=EVFKmw4Oby5gXvKgjn8iiysPcTdwlY39+bXv9I0cnv5skT4A3QQOVvaALRPk2Ujujctp/4vENwkVuUlkLFOVfU+ZrXvlVnUe9X3YnWWMubsWaBYo9xmJ6amlcz0jA/i920aDTdk/9zs1hMrN9IxFcK8yaYYJE4QHNGlsTAAOqR00wMpjIqt9UnSNTJ1QLPW754h2ChmCsDbJCr02V9hHmP5jc6T6CVS8TFG3GE3+xMuhayMEwXsYaGlleVqHPRePmSmGjr9hF1dYgUp4hPhjrk3i20BmjeOz5Ry3ht46fAOb4GViq8YxoPOT4Dv9v0PHAgoeNYKwsr5N9ObkI1iuuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 17:59:17 +0000
Received: from LV8PR12MB9134.namprd12.prod.outlook.com
 ([fe80::b15c:1b79:292f:31db]) by LV8PR12MB9134.namprd12.prod.outlook.com
 ([fe80::b15c:1b79:292f:31db%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 17:59:16 +0000
Date:   Thu, 19 Oct 2023 10:59:14 -0700
From:   Saeed Mahameed <saeedm@nvidia.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: mlx5 ConnectX diagnostic misc driver
Message-ID: <ZTFucmfKqU18Hkbs@x130>
References: <20231019082451.785aa123@kernel.org>
 <2023101923-tried-provable-72e7@gregkh>
 <20231019160145.GS3952@nvidia.com>
 <20231019092346.3387fad6@kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231019092346.3387fad6@kernel.org>
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To LV8PR12MB9134.namprd12.prod.outlook.com
 (2603:10b6:408:180::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9134:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4a95cf-0ab0-486f-dfcd-08dbd0cd1bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gYZyYpaXQ3bBtv/Q5EHRLJRHIZhK66LNOqUvg8arciHj+IlL/dJnaDsbGbi5VcLOipfnU/YsZlWKF89iJxqtZrjL1KAdxbR12yj6Jjqy1OeXYml1XWgnEz3BkZIIPJv7B5UZ1ByQLy+Rnp2iPCnljQVg50KBVGPPbWEGlCvf4dxhi70FDKb/pD0XFC5mZBzk2LjjrD3tZwSEArG4PBEp22o/+GntEjLJGepT56B2zxhTLxyShjXYA+BpZwUEsOMvk6GZgYZ7KuiUgrpDMx/K0GDLIpIpxDgy6yGR8ha79ZxCe8EB0eA8FQ82JWVi0XlIcA5CSu0UZsH4YwN9ViN5Urly6GJxavxZLkVnB9lpSeuqqNyo9o3DLfUuXXfRlXGQhtyPz0joI89lXTgdQBNas0WPh9V72WosaZMdE6H4RljBMblLtLg1eaB2iLYVAAM2Wh5lis1anDZ9+gzl9RgSqsZY4j7CCkYwnP6O7lF4N9uxuVgDh5dEspBFUZQoS3LuSeHp/QkRv7tv5H4KiPknsjs1y48nDAXTWG4ixGnhGXOkCRUstywBCp57+B7t3JJKh3GyJWyEUsfgZsOUi7jJ+mtYkhJwhSxLF+A7vzN31RQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9134.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(136003)(376002)(346002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(478600001)(966005)(6486002)(6512007)(6506007)(9686003)(6916009)(316002)(5660300002)(66946007)(66556008)(54906003)(66476007)(83380400001)(33716001)(26005)(2906002)(41300700001)(38100700002)(4326008)(8936002)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cvK6GfwqJs0ywkNmuDAP1ZkN2xiLwN9b4hTu+JMyMzy2SrUy0vGdtNDj+l0/?=
 =?us-ascii?Q?2hc0TpJzsUVKZx5fWAFrYpYnbCLYHeEdGOabJImbXzTiBmZdT6KunkS2Px7H?=
 =?us-ascii?Q?60iYlMIhaZYIxxtyGicEqjpDWeKNdkE44ah4nCFvz3RG5pLNydquClmm3UHV?=
 =?us-ascii?Q?T7ff16oRG7uHNpcZi1ZtdJHc8wTacSu+2bac9zd3I8p0tVdg7BQlXnh1JKF8?=
 =?us-ascii?Q?XTSMXCJlHBpiyggjDhUehOGhFo52X4dW/DrTY1rmXB2EIjllfUbR93E1o4z+?=
 =?us-ascii?Q?dEg/4wHthpuvC8V8E1LpZuxmDlGK516NSuhQE0r1dWeNLlJ7vh/Vhf8d0vQl?=
 =?us-ascii?Q?AeNQ7ol5ObhDPr7++aKJfv0L/Aqrs/MAQ4JLMdoehNbqml3AeIgkhTp+2l/Z?=
 =?us-ascii?Q?yOZ0GidoNT22NRC+kQqk5KANkQdOnbrQgYIfWTpXrruN+QxB1bSAFcQyy7oc?=
 =?us-ascii?Q?UVBrmidwoHNmRHLUlCyvYZ7iSfex1Hz7K7uaTZ8YlXwCio5dF5b5usKneMj2?=
 =?us-ascii?Q?c2MyWTPfYnHzBH4HXWXmTrmjmPJsmEEqhVzrmZ2atHczV2fBiU+t1Yj8lQJn?=
 =?us-ascii?Q?HrJ7gVL8WEdhwe+Fe0a2fbvPa+NIpVvQDsSqe34mOgLXXpiMR6X+Sxfn7jj9?=
 =?us-ascii?Q?2qlYDEYBCUwDlbOaQv/Vn/qSTOdILT1+CytZxGM+PXPZqNzy5GvDqn08b25u?=
 =?us-ascii?Q?SuIJ4waAQQyltCv6PbeeF6LDMgKzmt/+BGEt9AUyn6k/+nfrfBpmucVwoUcw?=
 =?us-ascii?Q?RRgAlezJ6IgHv13nXsCEvawrU/zkSuHRbvlMjwZ3u2hlM6Tm1CzriU5A0yK/?=
 =?us-ascii?Q?zpSkSmaEI4n1Cycqv2h9Bj6YopRsw1Az46rWyLFYaKgmE+dSNMZqv0Z5Ciam?=
 =?us-ascii?Q?WBjPSvRAUyTRCMPqVrqp1+gsjTcpYHXqeXslFyLxxYnR3I/AxRmgZkC7/5Yv?=
 =?us-ascii?Q?BKz1yPzm0gJZ4Ex5grY8Ue0pc25Z+t9TxhAuzr4knmr+sVbG1o1Kn3kuGRpr?=
 =?us-ascii?Q?sDMkat09J06J/DXg2BX3g6i6Zp08mOVJ60eTM9tbNcAXcYUB5RX3mtWF5/tr?=
 =?us-ascii?Q?uHAZOgP8fu1J1NvYxa2cbbmvcMK24/SoqIK96DRRSWOxSdQcANRkGQYRoQ+S?=
 =?us-ascii?Q?jKmtDT4YUmWdbHSP+A8fvTMz8Z9DQ5Tu9rVoOM/HxacqrED1yMrwnblLmN1L?=
 =?us-ascii?Q?DjTP/iVgQva4rF/yFtJzhbqHw1jeSVHDVdR82k9n7v+zJ+Jp3JSdZxJqzuDw?=
 =?us-ascii?Q?AAzJ6sCbohNY4/JAL0/oAUDvQYZNoFRCZ90tSwgQnDp9c6VjwOaLjNRLnlW3?=
 =?us-ascii?Q?ZpUaN5EVzlW/2C1pBW1s0fCwWU8NqokcW8/FsvVCMZR/8VelPIfzM8phAoPO?=
 =?us-ascii?Q?OYhiBy4u6fyiorJwAEjI5xQjuB4p0aMKjLEa7wn43LkQ655VjBxBSlj2DsVY?=
 =?us-ascii?Q?wZVwYUgRcMCFUK7NxYIlcgGJWVtC0RGUmiO++t4x52qPft/prPIjpVspqrum?=
 =?us-ascii?Q?2JZt15tjZu/qnKkBD8L8uwobMuy+lnMdUklSTwUFv5hieqEt55wdbbBFUB34?=
 =?us-ascii?Q?wHZlRUA4aMrZTdU/GFcxFZ2NotLVB3jv2waZrdeL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4a95cf-0ab0-486f-dfcd-08dbd0cd1bed
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9134.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 17:59:15.9400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14tS43Xf09Wx/lFCPKqNb9vJ5+CeH3Ix4Horl9urZQ7BWsL9rKWNlYcbxHj0eBNgcDdHxeLP85/hG9gcpjtrnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Oct 09:23, Jakub Kicinski wrote:
>On Thu, 19 Oct 2023 13:01:45 -0300 Jason Gunthorpe wrote:
>> Do you have a lore link?
>
>No, it was pitched at conferences:
>
>Last year's LPC: https://www.youtube.com/watch?v=JGR9ZCeiW-E

Yes this was one of the problems I discussed at LPC, please keep in mind
that I raised multiple other unrelated problems too.

In this project we discuss the debug-ability features only,
The orchestration features are a separate project that is still
on-going work to be under devlink.

We all agreed that devlink isn't the place for such vast device debug
options, hence this is our proposal, a separate aux device that works in 
unison with other aux devices such as virtio, vpda,rdma,netdev, etc .. 

>This year's netconf / KR, but Saeed didn't have slides:
>https://netdev.bots.linux.dev/netconf/2023/index.html
>

At netconf/KR I only discussed the orchestration project we are working
on to improve an going work we are doing, multi netdev interface, such
as the socket direct issue we discussed, this has nothing to do with 
this project proposal which cover RDMA,VDPA,netdev,virtio,Blue-Field,
etc .. ConnectX debug-ability and diagnosis problem.

>Really, you should be asking Saeed this, not me.
>


