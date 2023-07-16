Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869B8754D6D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 07:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjGPFjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 01:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGPFjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 01:39:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F841993;
        Sat, 15 Jul 2023 22:39:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EFAA60B0C;
        Sun, 16 Jul 2023 05:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A351C433C8;
        Sun, 16 Jul 2023 05:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689485951;
        bh=VR/aktToWTPl49fcsEjgIUIMPSUVD8CdQpptbazH2yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MZ+mAYMiWAXDTtjGWhT0wgEgRbs9EeJu/qe077DbVRRGiC5ADJAx4ngCdg+yn3gNJ
         L3sHpA+HH/ev9K6WeYiy698vSZiYF7miSrwPEnvS80KXMuf7lWQdKVuDnz/ATAi+ix
         uv4Eok6EPAPhW6g4gSjnuzFpOsm0UNNrCyT1qmXM=
Date:   Sun, 16 Jul 2023 07:39:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wuyonggang001@208suo.com
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hiddev: Modify Format
Message-ID: <2023071623-shrouded-slacker-97a8@gregkh>
References: <20230716040716.25980-1-zhanglibing@cdjrlc.com>
 <755134062a3e4f74ef781cb8593b0f1e@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <755134062a3e4f74ef781cb8593b0f1e@208suo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 12:11:11PM +0800, wuyonggang001@208suo.com wrote:
> Fix the following checkpatch error(s):
> 
> ERROR: "inode * inode" should be "inode *inode"
> ERROR: "file * file" should be "file *file"
> 
> Signed-off-by: Libing Zhang <zhanglibing@cdjrlc.com>
> ---
>  drivers/hid/usbhid/hiddev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
> index 59cf3ddfdf78..581dc33197d0 100644
> --- a/drivers/hid/usbhid/hiddev.c
> +++ b/drivers/hid/usbhid/hiddev.c
> @@ -213,7 +213,7 @@ static int hiddev_fasync(int fd, struct file *file, int
> on)
>  /*
>   * release file op
>   */
> -static int hiddev_release(struct inode * inode, struct file * file)
> +static int hiddev_release(struct inode *inode, struct file *file)
>  {
>      struct hiddev_list *list = file->private_data;
>      unsigned long flags;

This patch is corrupted and can not be applied.

Please try working on drivers/staging/* files instead first, to give you
a chance to figure out how to do kernel development, before attempting
checkpatch changes on subsystems that might not want them.

good luck!

greg k-h
