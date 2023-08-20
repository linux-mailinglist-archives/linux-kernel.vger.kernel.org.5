Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A4F781F81
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 21:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjHTTXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 15:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjHTTXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 15:23:46 -0400
X-Greylist: delayed 446 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Aug 2023 12:20:36 PDT
Received: from genua.uuid.uk (genua.uuid.uk [78.47.120.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998DD44BA;
        Sun, 20 Aug 2023 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20230424-rsa3072; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:
        From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
        Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:Content-Disposition:
        Content-Transfer-Encoding:In-Reply-To:References:Organization;
        bh=7602GOT5HJSHFctKhxiw1oFiDhE0TEzn/TTKrnBioPM=; t=1692559237; b=uI1qcMXA6JCx
        3Xd1MY0d6c57rJMnKEjQcltQ+2yP0+xGPvYjj6cgRXKbQZG9/oyqRoADi5a9dSJ7BS3Yx4zzeYSHT
        FH9HWmF1HF2nICKrtMa2na88WqC+VnS+IwoQzsgU4V5cFoJgvvYEqwb9jJMRmRriL+sSXGZhvTGxE
        4YuO864RMfE7KqllJDaIBHZP5M0Q5wcddM9cJfmn/v8Kk0q+W1KmodrtVJwEXfdreN9e+WA8J151S
        i9nFAFJ4lxikeyaoj4EbQVc1XZccWG/VmPJ+VX5AL9vGOQHxO84uYcw9GsS7icAPyep6vtlw+3M/V
        VcTsNZ/z7D6g7s5YOR4C2FPbjK9L3VVIgNsRMnzLQnn9tplNEFhYJD4eYsEFdzJG5C8UNLojUHmvQ
        maOmoX33ud5GRE+cVHPwoEQEKpfPA1q3qenKjps7eBpKoZC1Za+mj/kx53HnkIxffn5MOpWqMU+9R
        9tR3YlFa3K/QgNX8PFtoKcf0yC6ZGdtZxX0AtF;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
        d=octiron.net; s=20230410-ed25519; h=Content-Transfer-Encoding:Content-Type:
        Cc:To:Subject:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:Content-Disposition:
        Content-Transfer-Encoding:In-Reply-To:References:Organization;
        bh=7602GOT5HJSHFctKhxiw1oFiDhE0TEzn/TTKrnBioPM=; t=1692559237; b=tG96qLeP0CNi
        IKl0U57KbzQ7I13T5w1J5JeHg0vmXs7n7d7U/o7cio4S6JCnMTNFS4jAO5j31ktzCRJNPkdUCQ==;
Received: by genua.uuid.uk with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <simon@octiron.net>)
        id 1qXnrG-007rUu-1S; Sun, 20 Aug 2023 20:13:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20230424-rsa3072; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:
        From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
        Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:Content-Disposition:
        Content-Transfer-Encoding:In-Reply-To:References:Organization;
        bh=7602GOT5HJSHFctKhxiw1oFiDhE0TEzn/TTKrnBioPM=; t=1692558786; b=kg5fLdU9S03S
        xALXiHcnwX05C3xL92ZG5MdZT7bYXWPSsS7V0GUtN78Yb0zRGI8ht9ybpa9VkmadHG0pbTySnnn/k
        UB8fyThPUhe6yim5Jb/smCBaoKCHoNp0LqxOmPDhD0tGrUROBbV8tR2n++B2ymdm3dpRktqoPzSNT
        hWgvn65fj3oKsoUp2kjPNCoFC3kL/ayECFVQQ6sGcmJ1rMYquQbnVmEuxcDNB/xVtiKR04N97cSbc
        lL+RkSL+EEtHtANpN+PdUBfOZ+a3MRandejnxkI6Rh55OwXDLJNHcEhyBx9kjxwatpg733nEz0aTT
        r9E9/siRJaYCuYZ0D2vZaRYzZeYCN+9O4/C6em1ZD39aN72IRkV8wcomaGgbB8TAOQ+JnC81YQBKg
        xT/XdcS5x1eCPwid0OII9FZHNJikUldBKccn0Has1aRbMr3t+B/D8RM4aeBe0c88PqaYiIHzbZtw1
        qF3ERPU6RCqX8NO+XjT/jNVwJPd5iZA0YDFQWP;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
        d=octiron.net; s=20230410-ed25519; h=Content-Transfer-Encoding:Content-Type:
        Cc:To:Subject:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:Content-Disposition:
        Content-Transfer-Encoding:In-Reply-To:References:Organization;
        bh=7602GOT5HJSHFctKhxiw1oFiDhE0TEzn/TTKrnBioPM=; t=1692558786; b=FfeqeP0POutQ
        91/fqvc7d7uB93jo36LF/nMRxw5s3bxrUiV8ZKX/3zzvc4cQa5IfwNwM1mOjgKXHS0ec70qnAA==;
Received: by tsort.uuid.uk with esmtps (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.93)
        (envelope-from <simon@octiron.net>)
        id 1qXnrB-003Sfp-PI; Sun, 20 Aug 2023 20:13:02 +0100
Message-ID: <555fbc4c-043b-8932-fb9b-a208d61ffbe4@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
Date:   Sun, 20 Aug 2023 20:13:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Simon Arlott <simon@octiron.net>
Subject: [PATCH] USB: cdc-acm: support flushing write buffers (TCOFLUSH)
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-GB
X-Face: -|Y&Xues/.'(7\@`_\lFE/)pw"7..-Ur1^@pRL`Nad5a()6r+Y)18-pi'!`GI/zGn>6a6ik
 mcW-%sg_wM:4PXDw:(;Uu,n&!8=;A<P|QG`;AMu5ypJkN-Sa<eyt,Ap3q`5Z{D0BN3G`OmX^8x^++R
 Gr9G'%+PNM/w+w1+vB*a($wYgA%*cm3Hds`a7k)CQ7'"[\C|g2k]FQ-f*DDi{pU]v%5JZm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the serial device never reads data written to it (because it is "output
only") then the write buffers will still be waiting for the URB to complete
on close(), which will hang for 30s until the closing_wait timeout expires.

This can happen with the ESP32-H2/ESP32-C6 USB serial interface. Changing
the port closing_wait timeout is a privileged operation but flushing the
output buffer is not a privileged operation.

Implement the flush_buffer tty operation to cancel in-progress writes so
that tcflush(fd, TCOFLUSH) can be used to unblock the serial port before
close.

Signed-off-by: Simon Arlott <simon@octiron.net>
---
There's no guarantee that the write buffers will be cancelled in an
appropriate order because they could have been submitted in any order.

If there are successful writes in progress or if only one of the URBs
was stuck and later URBs could be completed, it's possible that an
later write could complete after cancelling an earlier one.

Should I change "struct acm_wb wb[ACM_NW]" to a list so that writes can
be cancelled in reverse order?

With some extra debug, writing 6 individual bytes and then calling
flush_buffer() looks like this:
[1850121.576468] cdc_acm 5-2.5.4:1.1: 1 bytes from tty layer
[1850121.576469] cdc_acm 5-2.5.4:1.1: writing 1 bytes
[1850121.876857] cdc_acm 5-2.5.4:1.1: 1 bytes from tty layer
[1850121.876858] cdc_acm 5-2.5.4:1.1: writing 1 bytes
[1850122.177273] cdc_acm 5-2.5.4:1.1: 1 bytes from tty layer
[1850122.177275] cdc_acm 5-2.5.4:1.1: writing 1 bytes
[1850122.477678] cdc_acm 5-2.5.4:1.1: 1 bytes from tty layer
[1850122.477679] cdc_acm 5-2.5.4:1.1: writing 1 bytes
[1850122.778101] cdc_acm 5-2.5.4:1.1: 1 bytes from tty layer
[1850122.778103] cdc_acm 5-2.5.4:1.1: writing 1 bytes
[1850123.078510] cdc_acm 5-2.5.4:1.1: 1 bytes from tty layer
[1850123.078512] cdc_acm 5-2.5.4:1.1: writing 1 bytes
[1850123.563234] cdc_acm 5-2.5.4:1.0: acm_tty_flush_buffer: transmitting=6
[1850123.563236] cdc_acm 5-2.5.4:1.0: acm_tty_flush_buffer: wb[0] .use=1
[1850123.563245] cdc_acm 5-2.5.4:1.0: acm_tty_flush_buffer: wb[1] .use=1
[1850123.563247] cdc_acm 5-2.5.4:1.0: acm_tty_flush_buffer: wb[2] .use=1
[1850123.563249] cdc_acm 5-2.5.4:1.0: acm_tty_flush_buffer: wb[3] .use=1
[1850123.563250] cdc_acm 5-2.5.4:1.0: acm_tty_flush_buffer: wb[4] .use=1
[1850123.563252] cdc_acm 5-2.5.4:1.0: acm_tty_flush_buffer: wb[5] .use=1
[1850123.563254] cdc_acm 5-2.5.4:1.0: acm_tty_flush_buffer: wb[6] .use=0
[1850123.563255] cdc_acm 5-2.5.4:1.0: acm_tty_flush_buffer: wb[7] .use=0
[1850123.563256] cdc_acm 5-2.5.4:1.0: acm_tty_flush_buffer: wb[8] .use=0
[1850123.563256] cdc_acm 5-2.5.4:1.0: acm_tty_flush_buffer: wb[9] .use=0
[1850123.563257] cdc_acm 5-2.5.4:1.0: acm_tty_flush_buffer: wb[10] .use=0
[1850123.563257] cdc_acm 5-2.5.4:1.0: acm_tty_flush_buffer: wb[11] .use=0
[1850123.563258] cdc_acm 5-2.5.4:1.0: acm_tty_flush_buffer: wb[12] .use=0
[1850123.563258] cdc_acm 5-2.5.4:1.0: acm_tty_flush_buffer: wb[13] .use=0
[1850123.563259] cdc_acm 5-2.5.4:1.0: acm_tty_flush_buffer: wb[14] .use=0
[1850123.563260] cdc_acm 5-2.5.4:1.0: acm_tty_flush_buffer: wb[15] .use=0
[1850123.563568] cdc_acm 5-2.5.4:1.1: wrote len 0/1, status -104
[1850123.563571] cdc_acm 5-2.5.4:1.1: wrote len 0/1, status -104
[1850123.563572] cdc_acm 5-2.5.4:1.1: wrote len 0/1, status -104
[1850123.563574] cdc_acm 5-2.5.4:1.1: wrote len 0/1, status -104
[1850123.563575] cdc_acm 5-2.5.4:1.1: wrote len 0/1, status -104
[1850123.563577] cdc_acm 5-2.5.4:1.1: wrote len 0/1, status -104

 drivers/usb/class/cdc-acm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 745de40310d2..00db9e1fc7ed 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -863,6 +863,19 @@ static unsigned int acm_tty_write_room(struct tty_struct *tty)
 	return acm_wb_is_avail(acm) ? acm->writesize : 0;
 }
 
+static void acm_tty_flush_buffer(struct tty_struct *tty)
+{
+	struct acm *acm = tty->driver_data;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&acm->write_lock, flags);
+	for (i = 0; i < ACM_NW; i++)
+		if (acm->wb[i].use)
+			usb_unlink_urb(acm->wb[i].urb);
+	spin_unlock_irqrestore(&acm->write_lock, flags);
+}
+
 static unsigned int acm_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct acm *acm = tty->driver_data;
@@ -2026,6 +2039,7 @@ static const struct tty_operations acm_ops = {
 	.hangup =		acm_tty_hangup,
 	.write =		acm_tty_write,
 	.write_room =		acm_tty_write_room,
+	.flush_buffer =		acm_tty_flush_buffer,
 	.ioctl =		acm_tty_ioctl,
 	.throttle =		acm_tty_throttle,
 	.unthrottle =		acm_tty_unthrottle,
-- 
2.37.0

-- 
Simon Arlott
