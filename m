Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC2F7DBDCD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjJ3Q1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjJ3Q1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:27:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5214F1;
        Mon, 30 Oct 2023 09:27:27 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UExUPN007745;
        Mon, 30 Oct 2023 16:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jm/R6KRA2W21JvQwRBpLxy+9HHpN8ayQwQqtG2bLlE0=;
 b=PZPkeGkLExzUgKDt3vOt24DA6b3+bcRztQZU1v4/7ABaWC+j7uPTjZs4RbsDQ6PXS8x7
 FE1Zf1L1Abfd+8niXT1+ALBgbslCwlJdZDC/dz7Sy28v60vtVYvYHViNihuepW/lhXnD
 K/C7sv/TqRLFfYHtL+3ESaNsnRp6E8Sy+SChWhtAyOQ0dP0HMAzr578WTJcGWNUezNAC
 F/Q6DJGw0tD9oH/rUgCZblYMt6YedtdBgOBmsGto9zzsN+fxSuWpxD+xLyTIca+dXa7I
 gw+KA80ErLv3Q6PZGocepKnul9px6Bde13wEjhPnrrwnQkdHXbeasV3xjy/YVvrYG3Vm zA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2chygkgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 16:27:20 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UGRK6v007483
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 16:27:20 GMT
Received: from [10.216.30.48] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 09:27:17 -0700
Message-ID: <9d71fc3b-f7a9-9f23-6fbe-a7665954cd30@quicinc.com>
Date:   Mon, 30 Oct 2023 21:57:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] eventfs: Fix kerneldoc of eventfs_remove_rec()
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20231030121523.0b2225a7@gandalf.local.home>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20231030121523.0b2225a7@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: luB8N8f8cj3zTVPpKHG2HhCZl_liRfVI
X-Proofpoint-GUID: luB8N8f8cj3zTVPpKHG2HhCZl_liRfVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=953 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300128
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/2023 9:45 PM, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The eventfs_remove_rec() had some missing parameters in the kerneldoc
> comment above it. Also, rephrase the description a bit more to have a bit
> more correct grammar.
> 
> Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode");
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310052216.4SgqasWo-lkp@intel.com/
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
> ---
>   fs/tracefs/event_inode.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 5a3cc5394294..1c28e013201f 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -977,9 +977,11 @@ static void free_rcu_ei(struct rcu_head *head)
>   /**
>    * eventfs_remove_rec - remove eventfs dir or file from list
>    * @ei: eventfs_inode to be removed.
> + * @head: the list head to place the deleted @ei and children
> + * @level: prevent recursion from going more than 3 levels deep.
>    *
> - * This function recursively remove eventfs_inode which
> - * contains info of file or dir.
> + * This function recursively removes eventfs_inodes which
> + * contains info of files and/or directories.
>    */
>   static void eventfs_remove_rec(struct eventfs_inode *ei, struct list_head *head, int level)
>   {
