Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D5675484B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 12:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjGOKs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 06:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGOKs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 06:48:27 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2123.outbound.protection.outlook.com [40.107.101.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CFB35AA;
        Sat, 15 Jul 2023 03:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMPhbGjKV3pslnaqd+0hpKvxAqYRX26G4vBXqHvGRx3hIlqdj2e1Y8k12gAxJHr1QaEmfLdALTPQR6IvUExw1xH+KS+Ih1c+4J2l+4jeFBYoT2u8B/TiyKyojKGcrninf0POMuOJNuCAiI0YUqfvSc5EY7/NmiXlFjQsh49DWxrEAand1xcrfOsdPxnvYoeYET+GzL4PsS7DASAd6KrFMAH4kRdHzinoxcPJnn6j+5AQPmnNJqAqBEgUEJtra1f1UhM0kvvQ4zvNIY9yVbp2g9TBhkmcYjUJfGFTb/xUpBdx/RO7+Qd1DwHstJ0gR4Iw9CRPDPf3QEkdsS5rEzfDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34cTv+CfL/UhDRAHXXcj8Nfbhj62TIh8zoWet/lxa6Q=;
 b=evh31n9WDemWmtbSNYmk5pyEU7IGXHJ45id/I45Kq+82c40Lu2qZmK8BnLZQ4P5ZHvCArI3dS4+5M5rHDUacwVoTQHtTUqvk8xxnMp3ix8At8EMPJwYkc5kek9NhVHnWoQ/Fg0EFEyJaNT5WjGSscmLbOA7dlaK1FRm2s2htmsr7q1uTQ1yoG1mF/WX7FQdVbasIfEOy4kSZ33IKqDIUI2D/7KyCYgrDkwhQi3XFuw61j1pbYBOJxB4GqC7BUIDjgo60qmxwK6kGFL3+UWRi0Z67Vv/a/7PcSt+KK4Y2bNRYkZcZQe9+WiInlTY10sEf1yJvdYe9y/JNALpceO0q9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34cTv+CfL/UhDRAHXXcj8Nfbhj62TIh8zoWet/lxa6Q=;
 b=V7t/s8qjhGBiIgDYKtoIa+zx1OFa8DAehaZPA4zrOPcl+941B9uInkUEYT3J0FqteTrmkGf2Hlgc4v2vA3n0PmnW6517mRF8y8hdqbNH9ay3oB/RkIbKMqNgqM23qL06iTRPmeuBhlzBvKztfTY2Ce72CJnTAzN7sI7xQFmidcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW4PR13MB5838.namprd13.prod.outlook.com (2603:10b6:303:1a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Sat, 15 Jul
 2023 10:48:24 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 10:48:24 +0000
Date:   Sat, 15 Jul 2023 11:48:17 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Minjie Du <duminjie@vivo.com>
Cc:     Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:MARVELL MVPP2 ETHERNET DRIVER" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v1] drivers/net: marvell: mvpp2: fix debugfs_create_dir()
 return check in three functions
Message-ID: <ZLJ5ccZcmo/ol/Dm@corigine.com>
References: <20230713044507.3275-1-duminjie@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713044507.3275-1-duminjie@vivo.com>
X-ClientProxiedBy: LO4P123CA0196.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::21) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW4PR13MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: 315ccb60-9472-47dd-2c7e-08db8521033c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0pxkJ+dAOt61xYqIAfCTZW8VEQGWB3C6OQkcawEq4Eroet5iCeaOe6CuOeGJKdrTJviowTYdtGWk+DPbwXJ1EY4CYTST4S/kA/ri4zU82m3u9OhCOKL8YUqdfMvD5yzqSL3vs5OIVd8x7dBxlh2Sh4KaXXpYGgNOBWbn+q4JcA9JhPL7p0MNxMybf4iPel2PUxps0N4DirvmWCEirXk7E6LI7bP/29+AtkyQ+UXx7PGtADTT2Ikco+wVU2us/S3Ncb0M6MZ+Fr5JH0iVOv2pN+5AtCB49/eJ6IiWRB45TcPuMk/u+gpRNkXjQfcysRvEUYdZvFwtWcm6P2vbcaj9zoSlScIq+QJaQmBHeIhk0EjX9A9Z0wMedtKWvYZG/My1BsAi3x419UTk1FEKfPVVkK9o6CNeZMHJKBdlHy0bMyPhs5l78uSDb5nAjN3cSsWGgken9vW5UKbIob0jEmnL1InraySkGmC/Wb0wyYGD33cmxSQVsZgk80ATxdcJST+q2+ZgLOF4xdqijdqBU4AU9Ny0r1+GMk2n8XYwRUpzsN1cchWIMgtXI651mR8ROp5KIT6NHMUe9JEtcXymP5uifPWm3E9/tLL3Tv3b4+vOVBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(39840400004)(376002)(451199021)(2906002)(83380400001)(2616005)(86362001)(36756003)(38100700002)(186003)(26005)(6506007)(41300700001)(6486002)(5660300002)(6512007)(6666004)(66476007)(66946007)(66556008)(6916009)(316002)(4326008)(8676002)(7416002)(8936002)(478600001)(44832011)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zztKJwKaDJgMK3cqVTJ+7IJaUpx13+34InJ0yFZiwIxCirCh5CjLFTLCo+dv?=
 =?us-ascii?Q?a72YQV9e9FSi0AXxqzOOrV0Pu6pyuZmK+SdW5vrqaXMMN+Z0eH7REvFnNCkj?=
 =?us-ascii?Q?R7CxLiBiHhWiFio6U+MHxGT/GnCaAlYIOXhN0kTdRQnja5U4uMxQDeeK2zWp?=
 =?us-ascii?Q?SKZSheShcRlm9q6WfMHgU1FF0fW6LzXhdda956zFt3xLrj1x3mxcjWbWI+HF?=
 =?us-ascii?Q?+UqQgZxjVFk8KujsfhBMI3YlklJ9jS9A+a97j5tyUQt5R1AFQ6qEy2/vXsFo?=
 =?us-ascii?Q?gNwg8RMQhIrwgHOjBH+SOVzpWubn/UH9OCNpqhowatoKp2N+JF+GMIh611NJ?=
 =?us-ascii?Q?QL+57rkZy3zzfs6biV7IrsKnaQZubERFSGCY+oiNgiR3APGX290NHaVnoEtu?=
 =?us-ascii?Q?wMKWROgRk2CYtVUxUceH3Oci4mvtTps0c+oEg1PQHkIO5JsqXU4rJhpUNZba?=
 =?us-ascii?Q?1BWEOjmOEscuJ748GPwBsIbSAhwYfq9Oe/pmion5xyHD12Maj7OYwVkz0iGQ?=
 =?us-ascii?Q?eBX64k1y/Emlc7aQeeLKWXsH9nsovtTwga+zlF2U0TuiKbRvEIPyXHFTGdxt?=
 =?us-ascii?Q?g74NwJMNdo/xHQzqDzkNRdTvRmr8KEWzGJeTNriT94vGsc9HfNMwCRG34QS4?=
 =?us-ascii?Q?7KkMwJoAqA0apptglEGgCapjdiAvYaXyH+laL/FB8qT99Z5saZtOYDLX6iAe?=
 =?us-ascii?Q?U/1Oa/z+UQzBJWCzhPnsZMYAUOfVZqqNzkBoMN1XgT0BPvkb2UMo0FoPy0sI?=
 =?us-ascii?Q?gJHu+scj+JTzMdykeYhRV5jn2YGog6anQSGqNaZfJFbO0XGJF822GUi5PKHt?=
 =?us-ascii?Q?Ypgw3ffki0Dm/w4XB/FdSgiXgZLTmdFWQM/xw4yJ9gxo1Be8PmaHpDaMIvyu?=
 =?us-ascii?Q?bBl2dSU0idC78PYJ/z+36mEzmDWiITwOoDKLtHNdvXcjdVk55AY7pDfPY7gr?=
 =?us-ascii?Q?5IEqXjpeEyPyN6Njj+4XhU95Pan9JD2VneWu7P7wSAReQgrZOFtPxEsBt/dO?=
 =?us-ascii?Q?ccF7ioMPwqdSuGW9b22FPvjWOeVUrelGGwsZb/WTQPTzB8cIa01epH0CbMti?=
 =?us-ascii?Q?h+bq0o8UXgjG+zOHSg/f4xI6G1IuMLgPjICidP3AIL0tqjZeclhoZR7gy/BP?=
 =?us-ascii?Q?xrNQKbumo2iddo5bZGZ5/njjtVaBSSRh3EzCvNZtsCwhqMQsS/153fs1PfAf?=
 =?us-ascii?Q?0JSCJQVti2sHxbdNWTqoDI6vB8m30fkRVz1/VHW2d0Re4V9Vd/1y8e1FVDG0?=
 =?us-ascii?Q?JluKqlQB6k/N9jmiqtYo7AlUZwK4AZibHOXmU+e0d2Q9mWp5pAWhFF+Iskyk?=
 =?us-ascii?Q?7d/xv+7phWD1mk8kFmXFtURNHnJNc8I0u7u+OkqER24wVcMQevrsFCR8Ukkr?=
 =?us-ascii?Q?qudyYPQQz1/YlI4XvjkcdoX1+Nlw/A3tLPec1qymSxXbkuGmY0pBCPdMktO0?=
 =?us-ascii?Q?7U1osAq6pBR8nlZ+5gRzzsGsrq8pdWodeulhTti9GEFDIZpNCkjTlrhcY7Wv?=
 =?us-ascii?Q?sX+jsFcBCk+Jvjxv9eArKNFKuG+49EBBSHGzIZu09ZvYUyJpP0QPWEFbxmb0?=
 =?us-ascii?Q?2+2jAVUr/wlpcoisPk8xrjs+wjYLEf1cjOMhCJebiI35wSmZnAyI56IX7/Mg?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315ccb60-9472-47dd-2c7e-08db8521033c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 10:48:24.2554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/wHH70wydqrMnt+9iDrBFYiMpm26l9MZrm466X6SgqPzm8DjxT+LYQCvE51H4DeS/OiNktYCQEK9Fk1QvFGbjP8lZWnhxWhgt3gdPMwc6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5838
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 12:45:07PM +0800, Minjie Du wrote:
> Make IS_ERR() judge the debugfs_create_dir() function return
> in mvpp2_dbgfs_c2_entry_init(), mvpp2_dbgfs_flow_tbl_entry_init()
>  and mvpp2_dbgfs_cls_init()
> Line 562 deletes the space because checkpatch reports an error.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
> index 75e83ea2a..37bff3304 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
> @@ -559,7 +559,7 @@ static int mvpp2_dbgfs_prs_entry_init(struct dentry *parent,
>  			    &mvpp2_dbgfs_prs_hits_fops);
>  
>  	debugfs_create_file("pmap", 0444, prs_entry_dir, entry,
> -			     &mvpp2_dbgfs_prs_pmap_fops);
> +			    &mvpp2_dbgfs_prs_pmap_fops);

Unfortunately net-next does not accept patches for Checkpatch warnings
of this nature.

>  
>  	return 0;
>  }
> @@ -593,7 +593,7 @@ static int mvpp2_dbgfs_c2_entry_init(struct dentry *parent,
>  	sprintf(c2_entry_name, "%03d", id);
>  
>  	c2_entry_dir = debugfs_create_dir(c2_entry_name, parent);
> -	if (!c2_entry_dir)
> +	if (IS_ERR(c2_entry_dir))
>  		return -ENOMEM;

As per the comment above debugfs_create_dir(), it is not
expected to return an error, and in general callers should
ignore the return value.

I expect a good approach here is to simply remove the error handling
for debugfs_create_dir(). e.g.

-	if (!c2_entry_dir)
-		return -ENOMEM;

-- 
pw-bot: changes-requested
