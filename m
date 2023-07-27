Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8389D7659B2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjG0RNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjG0RNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:13:31 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB6835AF;
        Thu, 27 Jul 2023 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1690477999;
        bh=iFsAPYra+5zB7SbmQBhq7Uej9I4TXLurpkpXK8lfY88=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=qKICobUHVChuchM5XNZtsd3hyErdxqqvEQfrGceKZSedROERX72DR2lIeR38XUcNk
         z9W+rXIXbcbldrs6SvSLXcajaIllDecFcoXND+HsRb2Lb99fuiEjdsDGudWcyDtUSg
         mcCg66QeouxTutPCnTj7nuw0N0nUVeMkQ/YA4v4k=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BF6721286121;
        Thu, 27 Jul 2023 13:13:19 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id cznVXVcn1UHD; Thu, 27 Jul 2023 13:13:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1690477999;
        bh=iFsAPYra+5zB7SbmQBhq7Uej9I4TXLurpkpXK8lfY88=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=qKICobUHVChuchM5XNZtsd3hyErdxqqvEQfrGceKZSedROERX72DR2lIeR38XUcNk
         z9W+rXIXbcbldrs6SvSLXcajaIllDecFcoXND+HsRb2Lb99fuiEjdsDGudWcyDtUSg
         mcCg66QeouxTutPCnTj7nuw0N0nUVeMkQ/YA4v4k=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id F1853128611A;
        Thu, 27 Jul 2023 13:13:18 -0400 (EDT)
Message-ID: <7e4c7af1adbfa91d05259ae65cade66521c3b182.camel@HansenPartnership.com>
Subject: Re: [PATCH] 53c700: add 'slot' check to NULL
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Alexandra Diupina <adiupina@astralinux.ru>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Vladimir Telezhnikov <vtelezhnikov@astralinux.ru>
Date:   Thu, 27 Jul 2023 13:13:15 -0400
In-Reply-To: <20230727153925.15297-1-adiupina@astralinux.ru>
References: <20230727153925.15297-1-adiupina@astralinux.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-07-27 at 18:39 +0300, Alexandra Diupina wrote:
> The 'slot' variable allows a NULL value.
> It is necessary to add a check for a null
> value to avoid dereferencing the null pointer.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Co-developed-by: Vladimir Telezhnikov <vtelezhnikov@astralinux.ru>
> Signed-off-by: Vladimir Telezhnikov <vtelezhnikov@astralinux.ru>
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
>  drivers/scsi/53c700.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
> index e1e4f9d10887..8e5468d1733d 100644
> --- a/drivers/scsi/53c700.c
> +++ b/drivers/scsi/53c700.c
> @@ -1598,6 +1598,8 @@ NCR_700_intr(int irq, void *dev_id)
>                                 printk("scsi%d (%d:%d) PHASE MISMATCH
> IN SEND MESSAGE %d remain, return %p[%04x], phase %s\n", host-
> >host_no, pun, lun, count, (void *)temp, temp - hostdata->pScript,
> sbcl_to_string(NCR_700_readb(host, SBCL_REG)));
>  #endif
>                                 resume_offset = hostdata->pScript +
> Ent_SendMessagePhaseMismatch;
> +                       } else if (!slot) {
> +                               printk(KERN_ERR "53c700: SCSI DONE
> HAS NULL SCp\n");
>                         } else if(dsp >= to32bit(&slot->pSG[0].ins)
> &&

I don't believe anyone has ever hit this, but if slot were null, it
would have to drop through to the else clause to get a bus reset to
kick the device.  If we do what you propose above, the driver would
hang instead of crashing, which isn't a better outcome.  Something like
this.

James

---

diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index e1e4f9d10887..5296a13404cf 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -1598,7 +1598,7 @@ NCR_700_intr(int irq, void *dev_id)
 				printk("scsi%d (%d:%d) PHASE MISMATCH IN SEND MESSAGE %d remain, return %p[%04x], phase %s\n", host->host_no, pun, lun, count, (void *)temp, temp - hostdata->pScript, sbcl_to_string(NCR_700_readb(host, SBCL_REG)));
 #endif
 				resume_offset = hostdata->pScript + Ent_SendMessagePhaseMismatch;
-			} else if(dsp >= to32bit(&slot->pSG[0].ins) &&
+			} else if(slot && dsp >= to32bit(&slot->pSG[0].ins) &&
 				  dsp <= to32bit(&slot->pSG[NCR_700_SG_SEGMENTS].ins)) {
 				int data_transfer = NCR_700_readl(host, DBC_REG) & 0xffffff;
 				int SGcount = (dsp - to32bit(&slot->pSG[0].ins))/sizeof(struct NCR_700_SG_List);

