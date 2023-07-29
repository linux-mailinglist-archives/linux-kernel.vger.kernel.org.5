Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3E4767DBF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjG2Jwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjG2Jwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:52:49 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2120.outbound.protection.outlook.com [40.107.223.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE94ADE;
        Sat, 29 Jul 2023 02:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsjPi5t4dR0lqn+8Quw/2LFFugp7oiqapFd+BVzXpIdQ/g2v1ywN40jAJYY88bSRDFbpiy9qBGDd+XQJKi7eKl/JnDe5OLVLwYi0OiFSFf1Rcut6KBlfHo2gXGwpM6Y5zt9hSEjFU/dvHJRPZBEk96yWqckGZZi9vjVc0lwY2KGSOUJ1hvWqPSAPxNHVFgvxRA85MTIBjNGjqtvXoBtK3/MxfRBDNrSRfT1pfYSP1T76I7J3VvfdT9NO7I+fP1Ph2msFPKX5NX+3u1mohnu7ehHgZpjTFhiM2nh9i7+l9+uizaG2PmTD+gIEhLNIyZ+/mVPwUxtICTVD+FPDmrmt0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnFiMUwGTwWw+qFE7yBDSNcoo21Is4uk64U5mw/8luM=;
 b=oSzri/xuj1ypD4TCVWyfCAHWJJ5YC2mqKP4YoiHcj4qhUNBFVEm2IWBozCB/mzDy4hPaHxRGcAI4Sqpxnh28y3pMk8h88+sYXRKSKmphI2D9cXGSktUY5VbUgsb59Cwi3acSz/QFGPgfVQyxLWfLTNRF7PBc2QHxu65VPCsZAjsqMU7btdxzFi+eagYPSuC9tjCuv8z9T+hM5DwzOhnYYpJMyGOpPuP0bP7iZWzmAx3fRGarZQE3P4opOdgeP8PZD24HohUDdKU9PdHXgu5hvDmfZWfqeKJ8g59SX3qym70RXsVH/uhUuCdV/lJOTNtpGq+Dowx/mMAV43Rgf95wZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnFiMUwGTwWw+qFE7yBDSNcoo21Is4uk64U5mw/8luM=;
 b=ApvCHYcRvLe0ReUOGLfDkPvCUAcaRIN1ATgDyne4gy8NdUl4yBMMuQvgHKOCWJwl6GgvC+fxl5B9WG4sU73EGKRBqsYOhF9Q9v2CwgXtPemhtcD2bYMG//Ocw6BOOJxSc3BnIlys9EPAMFJGjr/mOviVEyhz+YOVFoKVO45aDp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5676.namprd13.prod.outlook.com (2603:10b6:a03:403::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Sat, 29 Jul
 2023 09:52:44 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 09:52:44 +0000
Date:   Sat, 29 Jul 2023 11:52:38 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH net-next] team: Remove NULL check before dev_{put, hold}
Message-ID: <ZMThZg+feS/PHE3x@corigine.com>
References: <20230727005741.114069-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727005741.114069-1-yang.lee@linux.alibaba.com>
X-ClientProxiedBy: AS4P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::7) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b13f918-d135-4dbc-d6da-08db90198e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXYVLffi6lqWx4Y2nZk513aHltjTv6SZjpHAl/6jpDL4zWsHBjIilnHpTqakaIJnHjHRi7xsHGTP5Qsdowh5l3uKx2Q/LWvw+HmMbswNShCa7thQnO6U0j3A3SMwcIDMK00CV+uapH0LQS0yfgQq2zbg7gqnGw6dpcXH4JoaOjsBoq4l41AYEERd0UwCN3ZsKSQkpiyeZlteXnHNKJ/LkAjxsR1afKRy/clJ41D2XFDnAKtS4qFgq8sccYSjUglIopz9uim7KmHzgKpgKT4S6jjI+s68lQD9oRBBelC2RrEbhUmkmMfbFSNzDwnZJ2YCWjuy2xcELmeamuOX9wUnEVjWp7oquhibNqyZkOY9zwJ1qxWLmm+0lgvfOJN0bt45lwpdZ1uZ8+wI7UDQvEkRhqzGQIo0QqRgsHvr9OmapM2ihyvtrqIdtt7kNTAfQrGvCisKp59mibd+zqVfnFWGhmqTq5kVWvAxavdnMCV7nleRsFMv6ShIbXFrGzmyJylpbUxuZnIzzuRqapgdKe+ryVMJEPqLmv1Iv/uKO2WSkA+rrhKrfrq870UAV6gI3zw3iACDc8B+1kVBvjlml24uXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39830400003)(366004)(346002)(136003)(451199021)(6506007)(478600001)(6666004)(6486002)(966005)(6512007)(36756003)(186003)(44832011)(4744005)(2906002)(8676002)(2616005)(6916009)(316002)(41300700001)(5660300002)(38100700002)(66946007)(4326008)(66476007)(66556008)(83380400001)(8936002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wBQ+BlpM2hw+QWmorlnUarrwyDy72jnpVfeQ/n9xZka6cSfg8KhBm/XNKipD?=
 =?us-ascii?Q?yuIRiP3dTeVHJ8Dx6v4CDvHi1cBvhs1jmKWaodTq29F4ew9O5Hj2OFnAF2U5?=
 =?us-ascii?Q?P9swg7854p8kG8zbc4R+djFk2VmUF8V02HYTyzL8qGx2oNWk0qUhFG6izTq4?=
 =?us-ascii?Q?qqWoZodj9CNutNUOzAck9/hmVZ64pJZQ0xvSR2y8eRlue4G0KIE5ScD9V61J?=
 =?us-ascii?Q?27ayLK6hyS25lcdgYttxWz4SRP2D3RkD7F41OAGeOPenwpobsX5+vpqavMIT?=
 =?us-ascii?Q?g5UEbPIQS4BelcIBsOx2A3mSnMBwLiwWQCcVWQcSy6jA4vPDxsJY61vVY1Rn?=
 =?us-ascii?Q?hWxX5h9qz0cNEdZ7AM0Uw+3fn2Eac5LRyud3p7PvuT8jPAQPwTVmGbTkSR6q?=
 =?us-ascii?Q?h1ed0KuoBJbJXsAzcsbzdzUPBL12jpuBi2viflMBUhCRw8YxIQvOhzdJz3VE?=
 =?us-ascii?Q?1OFtWRqOqSNa5g1221cLAxYmwh3/Aoi8GumslUmxCzvKFPI3p85e8ELN5WQg?=
 =?us-ascii?Q?WDiFxcE4U8d3YWL7k+d4s8Mzrd93gl76SeU1mPP6OmzoH6PLmg5ikDdi7Npf?=
 =?us-ascii?Q?xEum5hCy6SANpA4m1IXvsIpRMQ8Z2u8xgYvap65rJiJLlFgPkFBKlHOF33ri?=
 =?us-ascii?Q?89PoIvQKqrWM/mWrLAu6awlExu/MlHVK0wdvmIExegQhYE4XlIaCOV4dzRPl?=
 =?us-ascii?Q?i8tKJwge9YRMhCSerK8hdJvk8qM02Y6fJAr34NLXgT74iy3u++AEfc6lab89?=
 =?us-ascii?Q?ohybPWG2274YRJoywFRcYu+qflqJ+CHuL6Ri0B/U9iQf4MabRWaH/kmDzIiP?=
 =?us-ascii?Q?NuKMnysiDl4e4PIWiXfuzkzghATiux7pQsx6wlHugzJoPIc65kKlTBlMLow7?=
 =?us-ascii?Q?sysoaicPQavZBMQb9XQFS+7r+xjsf1cljdC5ldwwwrsvTXKrAPc6b+0PhXue?=
 =?us-ascii?Q?IxTRQEDYqXtT6OCtnJUDhUhmkxMfKpZjNetH3Byny69rdKNCCN+WjQn3KxMq?=
 =?us-ascii?Q?5E/F7ZRN/xzQezhf1/OJHi2F84ERJzeIa1k+QOhBuGRldz9G41CdzDggr9HG?=
 =?us-ascii?Q?gC5ghgKzt7OjNWSOwhXL6asWLjxdbPBT7LhAwQTE70ffOZyn+fcTYa78KHEe?=
 =?us-ascii?Q?cC14QZIufW2GrdxdZCX5Lg9FVpJUT2AFSVvvxwZ0KM2Kw4CQRw+hLVQzTYu8?=
 =?us-ascii?Q?FWk5LDfoffBBmaoVUhzl7ZCLJER+1pb/q5XmDlRreprKFBYX/10VKVkPU5Bx?=
 =?us-ascii?Q?i+vykGuwaJGhbKgmlt2lS0bPk8jceoZvuYuXPn4zLUelCMgJrKVfdwr5rfYj?=
 =?us-ascii?Q?FynoKwud8RKMoYhL2YcjsT8p40Qn+7ClGrCaAvciC9P8wX7To2QamrD/3TeC?=
 =?us-ascii?Q?+wpRqmjDa4FVALIVj4yg4mnlVcVY4Y1IBoVqZ30svI075pSROd15oU4lykeE?=
 =?us-ascii?Q?pXXot76Umd8qT8UUqPXzh5RiBvWIBGT4WleNZEOWhb+4LUWNrqd4ruDwNK9+?=
 =?us-ascii?Q?ogjAb2JvSQF0cjr18gREThT9CsEIrJJWGZ3yQcqcRjT69wV3hep6uqu/VYyr?=
 =?us-ascii?Q?2+bsjVQsTGa4J7geSfjmx4x2MNQR29ZTPmlRh0IZ3YM39EJgYIkJWZ/Fe/V6?=
 =?us-ascii?Q?VcQstJ0VMB91mYP9bic3SgMO7XdX2j5Yw1mr5V9BkSvHD/3hEpeEeI594ept?=
 =?us-ascii?Q?9rkVFA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b13f918-d135-4dbc-d6da-08db90198e77
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 09:52:44.4402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wgYby5mezPutioPPxmlGHA4Pb2PFZd6Hrcd0mEFk6iix6gfuvBe3xuH/rJDebA6PTLPhVosJ5shgC+hAcka7wuSpHzFYF1Us2vOPDDkqBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5676
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 08:57:41AM +0800, Yang Li wrote:
> The call netdev_{put, hold} of dev_{put, hold} will check NULL,
> so there is no need to check before using dev_{put, hold},
> remove it to silence the warning:
> 
> ./drivers/net/team/team.c:2325:3-10: WARNING: NULL check before dev_{put, hold} functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5991
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

