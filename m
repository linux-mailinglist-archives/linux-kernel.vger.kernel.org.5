Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBD47EE494
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345302AbjKPPsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345297AbjKPPsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:48:10 -0500
Received: from p3plwbeout16-02.prod.phx3.secureserver.net (p3plsmtp16-02-2.prod.phx3.secureserver.net [173.201.193.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE8219B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:48:03 -0800 (PST)
X-MW-NODE: 
X-CMAE-Analysis: v=2.4 cv=SYYyytdu c=1 sm=1 tr=0 ts=655639b2
 a=dFffxkGDbYo3ckkjzRcKYg==:117 a=dFffxkGDbYo3ckkjzRcKYg==:17
 a=TT3OXX8_H1iH7GK2:21 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=t7CeM3EgAAAA:8
 a=FXvPX3liAAAA:8 a=hSkVLCK3AAAA:8 a=hlfSdipmgW7WWFGKQN0A:9 a=QEXdDO2ut3YA:10
 a=EebzJV9D4rpJJoWO5PQE:22 a=FdTzh2GWekK77mhwV6Dw:22 a=UObqyxdv-6Yh2QiB9mM_:22
 a=cQPPKAXgyycSBL8etih5:22 a=b0R6z3OkPTeaBGj_aaBY:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
X-SID:  3eb2rPcI9GN7i
Date:   Thu, 16 Nov 2023 15:47:59 +0000 (GMT)
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     Lizhi Xu <lizhi.xu@windriver.com>,
        syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Message-ID: <261429818.1734406.1700149679974@eu1.myprofessionalmail.com>
In-Reply-To: <20231116031352.40853-1-lizhi.xu@windriver.com>
References: <0000000000000526f2060a30a085@google.com>
 <20231116031352.40853-1-lizhi.xu@windriver.com>
Subject: Re: [PATCH] squashfs: squashfs_read_data need to check if the
 length is 0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.18.49
X-Originating-IP: 82.69.79.175
X-Originating-Client: open-xchange-appsuite
X-CMAE-Envelope: MS4xfP5dWoFg+M+ZbHqU6VfYXdfwfo2GWM4bkl/BocaMV3PJM36+tJnayLaj5N+fOY/wfJtaAqSRbDzYoK4RvQBifMSoZXLM5ZW8UGrGj7gJ4TqUNX+EXXji
 Y+x2GdNvPOiSAkVqTy/8r7vRcMjYjJMN5uSagylNF1qNQ38kzHI6WKOkvpCTlJz+j6A1tnd0qtQl7EMmrodQHNEytKXfEkiaYP3S3mGZnE77Tvp+7Kds8ORe
 JvIbZmaKwKUyt5hvGMfnvz17XtHuCFProE9plCbX6enG5Fa1Uk2NJfDJdJwjoOli6FQM19zC0ZQFeJR3/VKL0jCk7L1drGh+tLH0Uadq7+0UFh0GvewPUM+2
 gh5wtf6jf6mAbVpZw/VMmGtCBlFHZWZDp6kqOepZj977Wh1eLhZ52TB1uTboFJP0UIMT15TPmG4RV7E2SV0nzMhKHA+wsaWR5675kyeWfsaOnBXzV/EuEMX8
 gGQAGF8S3HNEg7m6n6EaNYcc6qzDTRajc9JboBEUdLnbA7r3ELq4TmqMoaNq3Ukuuwfsb0lmZvbNdXzM
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 16/11/2023 03:13 GMT Lizhi Xu <lizhi.xu@windriver.com> wrote:
> 
>  
> when the length passed in is 0, the subsequent process should be exited.
> 

Reproduced and tested.

Reviewed-by: Phillip Lougher (phillip@squashfs.org.uk)

> Reported-by: syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  fs/squashfs/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
> index 581ce9519339..2dc730800f44 100644
> --- a/fs/squashfs/block.c
> +++ b/fs/squashfs/block.c
> @@ -321,7 +321,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
>  		TRACE("Block @ 0x%llx, %scompressed size %d\n", index - 2,
>  		      compressed ? "" : "un", length);
>  	}
> -	if (length < 0 || length > output->length ||
> +	if (length <= 0 || length > output->length ||
>  			(index + length) > msblk->bytes_used) {
>  		res = -EIO;
>  		goto out;
> -- 
> 2.25.1
