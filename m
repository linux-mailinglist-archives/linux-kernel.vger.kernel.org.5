Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A609796F26
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 05:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbjIGDEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 23:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjIGDEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 23:04:33 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2094.outbound.protection.outlook.com [40.107.215.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D895A1B2;
        Wed,  6 Sep 2023 20:04:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyxUNXe/oa3IQOolMV1nf1eGO5f+xr9Kw0tti5K+NG/TL2Ac/8DaqVXBMSbbfO69x47Ewhik94evzSuR6A3uEHWxObMe2J58CRdxai+sIKog7wxUIaTIFq/v4MWihsHzap2dhSEW0ZhBSe3NksJx5EGRosEw9Su+2jf6M+CMIGIn7QNOt/fgoyap6t4SFlrcRaj/wZKtyFq0RPC0fn/x2ZArl4kauyVc7/9uwLMRfs5+ac/1EKmqI4nJBjYjpl3pLMQJqGqu5v1Jup4LfJoAvvXGY3Cv8c9FehfhT3myV3VpH5uMTRMvi12dPr3rQ6W+6jSMpHmvab0mAPuRp5Ityg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeZGto/wqpzP5EOFqcwX6hCubrUC8mtpUBReqwkOOZk=;
 b=ARMf4Xdocl4d3e6SE8IDmX0fNqADqHFHEmJt4pLju7Toue2AqTaky5klm6YnqZF+bI8MtcJQnytGicBKkS2h//xwyuw+Zzk0R/nodAHwm4NEYqbb4kQ0562Dwv+IEk+0Y3Bxpz79+wdlNI/FhNUUDt0+t6XdwFR/MhwMkb9vwj+CzPHcu/+BrFCavFw5hFdVq9xQybDpwbyNVR2oUC5en/POelENQ+8n+ofuX3SFd5JKUqZaNKCcpOK7H3/Ut5tbDZdOec/Gi8gbSaolzVuKMe0AvXoTGhkxv8tkJrPI/9t2+XXNXfbzSePMz9S25lYMDQicEU4nwnumdN5kmzWb2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeZGto/wqpzP5EOFqcwX6hCubrUC8mtpUBReqwkOOZk=;
 b=ghJxTizhpqe+mLdN8+CW5hpPHEc4v8B0Cf0iX4Mxw5cwMLbkOLru6sU0Gu0eRASfEVT1diar95NdOBtgnuXEYF0O2GHGkEymCqezFe+nv/CvMLxeQOAsvywba2Wm83+X7UQQugxeOM57tIijQu3E6Z8/distZGEilxqUl4B+XkIEHlDPpnRzEtf0ixnR7aEX4NqqN+CsBt4w/07iw9qFBh79590VloerUHWCYt3RFPFbB6hfcfScxqBwx6CgIUufG90YAGEO6/Ema99CNRBsBrWMe/r2Je4d321OsJa9yy365rBKdyJu2NhD4RCMxE0rZcm8q1HhKHy/IfoCCatrBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com (2603:1096:100:3a::16)
 by SG2PR06MB5382.apcprd06.prod.outlook.com (2603:1096:4:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 03:04:25 +0000
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::b59:294f:e052:238e]) by SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::b59:294f:e052:238e%6]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 03:04:25 +0000
From:   Wu Bo <bo.wu@vivo.com>
To:     bo.wu@vivo.com
Cc:     audit@vger.kernel.org, eparis@redhat.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com,
        wubo.oduw@gmail.com
Subject: Re: [PATCH 1/1] audit: remove redundant 'fsnotify_put_mark'
Date:   Wed,  6 Sep 2023 21:12:12 -0600
Message-Id: <20230907031212.1398801-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230907015152.1388111-1-bo.wu@vivo.com>
References: <20230907015152.1388111-1-bo.wu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To SL2PR06MB3017.apcprd06.prod.outlook.com
 (2603:1096:100:3a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR06MB3017:EE_|SG2PR06MB5382:EE_
X-MS-Office365-Filtering-Correlation-Id: 9334f2ba-2ad2-4258-edb2-08dbaf4f2444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8wle9VnNG3MQlj8u27mUgN2bV9tlao0aTfi9YF9A6JGfsBmfNo03L+N3gPizPe6OpUy71QE0cf5uwt+KEVgcBX2wmdzYMJ/CBmk/GaWd7pfC+FTWE2supMYLjMd5eFvxCZUHz1498GJzyl4mG3Daoghkaphy1pTbOOXjoYb4B8diCmZb+x4+2Z9KzNOquVcY7i+ddQDLb/AWLHXQVbe68xSK13jdP+NWQXv+unpVnZ/nwP/wVNHb2Ipojpvw3PIRoy615JnBum2EOzZkoRIHlDGQFDG8WwaRM40ZBsuiOXuQ3j/dGmTLrDjwRu1+49PkcHqe/aVucsGfep7a5DJ1XyVqZeKbBE3RA6D6e15SJHLoEhj6ripU2F0kbjAWDegrYl145m0Du/pUxGDj54GXlVwL/52hfcQO1pAFB3SF6D4E7TTyAbSRBg+7kSQxAjVJNkRsxgR1zU/IxBPc9Xupf88pIlE+JfK+DPGREOhhlujybtlruIZQglGf/rQ+v48s/jaRO0h13ntayUHF+dBcZTI561OXAo7IdTDFd9X0ShaeMJxko7csW0ixlxfPXe4Pq/hNurAxdOY2vZrDfjtzw/Kr+QR7JWQaPYCzxdFe/lDRoiLxfeFTcWikg+uwNwJp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3017.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199024)(1800799009)(186009)(41300700001)(36756003)(86362001)(8676002)(4326008)(8936002)(34206002)(38100700002)(66556008)(66946007)(37006003)(66476007)(38350700002)(316002)(5660300002)(4744005)(478600001)(2906002)(6506007)(6666004)(6512007)(6486002)(52116002)(2616005)(26005)(1076003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0XHBnmZs5EfMJVn++WLUxJKX2cQkQw9w7aPryGSatB1Xb0siOTqfG7FioOwE?=
 =?us-ascii?Q?pS6/BzvSDI55DgC2cFbXCAWcYlz/Yl6o5ymvyx3NsI1fm4Tv+iPwabqdpznz?=
 =?us-ascii?Q?SpdcLljdANIgmfbY0JiB5ZJKOgCM2utN7LeT6jp9pi0nhCpfgMp6z2iRn/GZ?=
 =?us-ascii?Q?CxZJLTsQzNPEZLkCdLimLgwPMaixgT9sZ3ZsrpMCcWVRGh0JwSiy+kE0MTki?=
 =?us-ascii?Q?vPbrQUJWPZewaE6tMCJy4Vq10/HURKsddrdUMdtA60bp33FdIzResA5uUF+3?=
 =?us-ascii?Q?IxUuvbPQEBic7lbd2tUYXZh+eJlBHSMEa+JP6C6MMLvmT/4+tq/y0GFxEnjk?=
 =?us-ascii?Q?GvPg4b4BQBxfRO78MzQYHv1je1lbqoauBqXhC3izCkuFD268fosepz1ySB+K?=
 =?us-ascii?Q?QoA7ZTBrH7cXoZuT7xtQB0sF6FDJoC0sQlj1oMOQgV8dg1lSYb8d3PPvX5Ka?=
 =?us-ascii?Q?YympKAnZE5CnYP7N7q3ov+uVfRmjen0lJs0BfREGgUVjNlMCJaNqtIISaulC?=
 =?us-ascii?Q?5DnKHsfJSPe+ymd2ZEXbBBmcW/KeTSHMKzvTdIlUFo0pwU+VLJJZ1WzHjlFa?=
 =?us-ascii?Q?2n3d+Syla58oLxms0S37FGmGEUk5RU71ERlAoLAaaDTm1gtpaqlMv6Mthwmw?=
 =?us-ascii?Q?Sr+jxDl1dlZgF1DohpnzOsMKwWKuIAMtKDJoh3j5Kn7zeo400waViA0Nc49u?=
 =?us-ascii?Q?MKUsxdZgeHKi7RY1H40UZyGv+EWg56qlKRM0RLvdarm/gPfnPahzimADtxm/?=
 =?us-ascii?Q?PZ5pzPf2IQwnAXK8KMYnw0I/IHOlEfChl67/D57ovRHHe1X4dC9olkn2feYq?=
 =?us-ascii?Q?7CSwC1naJKHNCvtrpzsvBf4XyGlijW4ShENNz+BpgB5ILxk6lkULJB1vaXe4?=
 =?us-ascii?Q?WonhXs+G0dsfFy7kBhVzXLy7LqyEppXveMauv9FzOugqVTNBtZKQ+liHHR2w?=
 =?us-ascii?Q?1bO/fMkPVFl1/lKw2lZgJOmqHA/vm+jJ4+6MEPplE7AXMHb9l4AXO50fu/3W?=
 =?us-ascii?Q?uEPoobEN7JV8giwGStoIqF8TgatL/zVYkeF4xIxuJGfMWL4wuW2JRh8FFU6Z?=
 =?us-ascii?Q?2NdJEuXDTSDjf6YJOZHXoVluG2yv38YkmcUFTwlVgNIsxCB6e3A2sOXMqqki?=
 =?us-ascii?Q?CPqsWRyq57Lm/n+I7fw6iZkZgCBWjfm4ufowRKuo253wq1+hRU1JqGUe9VKP?=
 =?us-ascii?Q?iK52VF6shnY2IATUXiRNcD0lhoTFdPqCUGTVFS/SaBP8/3tKBHW0mnxzu2Jy?=
 =?us-ascii?Q?uliUSkj2/14+nglYe9FFCiBqoUjYpzMoINoucb7Cikf0qbBznpdwvHjiroDp?=
 =?us-ascii?Q?pFkUoIEAS0J89hOXdxutjKWqT/OvPqccujxF0gqJEwzktIMk8LcaXnyT3R8x?=
 =?us-ascii?Q?IU3tzf9O1SvSBsqjntnN1uEdVAhyKFeTlseigpSS2uLk73N7JCwjWbguEh3F?=
 =?us-ascii?Q?MEf628cUkrGc/KJjiQFjNOTxw69xuT3ok4pVjcAo0mvYskbz6LhQZsR32Yg+?=
 =?us-ascii?Q?xVGMNQpKP3QEsaM8qLbmoe7fZwJ2CSDSGW4HzlCCgmkpghT4uxs3+b88xwBm?=
 =?us-ascii?Q?WWGHs3Dgv3wpulIoHrfm383WX3AhXFmYdOhjHKbv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9334f2ba-2ad2-4258-edb2-08dbaf4f2444
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3017.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 03:04:25.1017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tj+rZ9rh+WKPRb8sGxmNCcAwrkBuCU2IcGXv7uJ/bpglBNQ+NLnxTdo4Eb6yV1rGaq5OXuvjy5fUc7NufXZDnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5382
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, pls ignore this patch. 
I misunderstood the difference between 'audit_alloc_mark' & 'audit_init_parent'.
'fsnotify_put_mark' in 'fsnotify_add_mark_locked' is pair to 'fsnotify_get_mark'

On Wed, Sep 06, 2023 at 07:51:52PM -0600, Wu Bo wrote:
> 'fsnotify_add_inode_mark' has done 'fsnotify_put_mark' if error occurred.
> So here to call 'fsnotify_put_mark' is redundant.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  kernel/audit_fsnotify.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index c565fbf66ac8..ff1cdda27653 100644
> --- a/kernel/audit_fsnotify.c
> +++ b/kernel/audit_fsnotify.c
> @@ -103,7 +103,6 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
>  	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
>  	if (ret < 0) {
>  		audit_mark->path = NULL;
> -		fsnotify_put_mark(&audit_mark->mark);
>  		audit_mark = ERR_PTR(ret);
>  	}
>  out:
> -- 
> 2.35.3
> 
