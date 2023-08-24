Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417F0786837
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbjHXHTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237857AbjHXHTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:19:12 -0400
Received: from papylos.uuid.uk (papylos.uuid.uk [209.16.157.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE21E66;
        Thu, 24 Aug 2023 00:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20230424-rsa3072; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:From:Sender:
        Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=f9YBXWcM1tAjh0Qj5b5U4ItNUNpxoe2GrqiEJrb/F34=; t=1692861549; 
        b=J5IuCXtT11f2V+f77s7CxZKTgcdCth97nUSoK+GY7eE9ZNKtvtKsKtCKr5lZiig+F8FTA7uOkH1
        uzsOosd+k0wb0lhfQOiM69mmz5qLmcwyDWmXJ59TyLuRuqAKNQKVLPr8eTvrwdcsapemL6Uemhr4k
        PDzSropfAzq8fnQzAjtR5OZzy+FROZnix4+EsGEs+DjMAdVxK6THyrmkFlt7kb8M6sK1fSUB9auyY
        b2yeqniA2tO7ieDtaR+Sh64DvIyP057qKh5W2dbKa3WV5bT4yqGgr2k2RX4KDa3ILEEFO/vpHg8H1
        AhieZBrWUYCr1ZrVUxpSl4wQ8EoMEcXQciso8TYDkh0d2ZTTcyzoA8OkariaRZhrDXdmLLX0AIVeA
        pBEmhLD4rlMhNjLCqbEH1ppHU2mWWb9AhZZq7j6y88Yk3ffif2YF0Ztk6iHu64+YTV+CsQw2o0whJ
        IA4Wpw2909LNUU1mYoRWF2BhlTytTZD5AveAvwtQYnOg90HMUn/d;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
        d=octiron.net; s=20230410-ed25519; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=f9YBXWcM1tAjh0Qj5b5U4ItNUNpxoe2GrqiEJrb/F34=; t=1692861549; 
        b=i1lGhmP4PsQS0W/cdMKOh/voLJ1byw2mUv3P9QVWTkzbNPJFIB9/mc9+Cjt/n4lg/GUD8yTQiaB
        R2mhIHv3WDA==;
Received: by papylos.uuid.uk with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <simon@octiron.net>)
        id 1qZ4cQ-00B0rp-52; Thu, 24 Aug 2023 08:19:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20230424-rsa3072; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:From:Sender:
        Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=f9YBXWcM1tAjh0Qj5b5U4ItNUNpxoe2GrqiEJrb/F34=; t=1692861542; 
        b=cEk3tomZoQ6jMPUoe/kykW/7itnhyYKUuFlolY9fWxcAYGj6M29wZeHCjv3QNmDq0TcQ9h9pdqU
        tJg3IwDM6qnbYpk3WEGum2MjqPhanRkfa9ybdUOcNwAEe+d29PgCrYINKq3nXMO5vszGR8FEhayWa
        ju6ADLlBDFxJwJMnCgYKEDac+WalO0ngBws/jfMDf4wK825A7gV24w0JHZnXZCaAPueeBSkC5BDaQ
        d/eaVSezsi2pqlElQKffcgg1yfGJffDt60Am0miUnLUfBfdVsmyQNYu3bwWlH+e97Yn0gToeNkleO
        UV49QylZnj411F+NNhtLzeNUQEX8TLuIVZnAnyF+oh6TQzY8DsgucUfDEnN0EeFUJj3GxC5VJfpmE
        EtNsLLTdAIxzH3pMd7P/kTlJ764lrzqMqgJvYaSsU8m4511COG9TgPPiM69oX6PnprsLmG+xWLzrv
        n1ylhKyKkvbEYlZJNa2iltVyfePMzPaFZruLywlOf6sHTb2RmAmd;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
        d=octiron.net; s=20230410-ed25519; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=f9YBXWcM1tAjh0Qj5b5U4ItNUNpxoe2GrqiEJrb/F34=; t=1692861542; 
        b=a2v9HTFp2r7spWg/VlGVAIBs5N0/9JOmo64KAE63R+WqfJqek3klrZWlbpFbjECi7Xhlez+TGS+
        1rUbTCf5MDQ==;
Received: by tsort.uuid.uk with esmtps (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.93)
        (envelope-from <simon@octiron.net>)
        id 1qZ4cL-004kF8-E3; Thu, 24 Aug 2023 08:18:58 +0100
Message-ID: <27304225-c8b0-9cac-94a3-e985e45aa41a@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
Date:   Thu, 24 Aug 2023 08:18:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: [PATCH] docs: ABI: sysfs-tty: close times are in hundredths of a
 second
Content-Language: en-GB
From:   Simon Arlott <simon@octiron.net>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <ea1a13ad-a1e0-540a-e97a-4c44f6d2d33b@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
 <40c5c70f-46ff-c5f3-212b-2badc47e49a3@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
X-Face: -|Y&Xues/.'(7\@`_\lFE/)pw"7..-Ur1^@pRL`Nad5a()6r+Y)18-pi'!`GI/zGn>6a6ik
 mcW-%sg_wM:4PXDw:(;Uu,n&!8=;A<P|QG`;AMu5ypJkN-Sa<eyt,Ap3q`5Z{D0BN3G`OmX^8x^++R
 Gr9G'%+PNM/w+w1+vB*a($wYgA%*cm3Hds`a7k)CQ7'"[\C|g2k]FQ-f*DDi{pU]v%5JZm
In-Reply-To: <40c5c70f-46ff-c5f3-212b-2badc47e49a3@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
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

The times for close_delay and closing_wait are in hundredths of a
second, not milliseconds. Fix the documentation instead of trying
to use millisecond values (which would have to be rounded).

Signed-off-by: Simon Arlott <simon@octiron.net>
---
If you'd prefer, I can fold the second part of this into my previous
patch which shouldn't have documented it as milliseconds in the first
place (but I copied it from the other entry).

 Documentation/ABI/testing/sysfs-tty | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-tty b/Documentation/ABI/testing/sysfs-tty
index e04e322af568..6ee878771f51 100644
--- a/Documentation/ABI/testing/sysfs-tty
+++ b/Documentation/ABI/testing/sysfs-tty
@@ -87,7 +87,8 @@ What:		/sys/class/tty/ttyS<x>/close_delay
 Date:		October 2012
 Contact:	Alan Cox <alan@linux.intel.com>
 Description:
-		 Show the closing delay time for this port in ms.
+		 Show the closing delay time for this port in hundredths
+		 of a second.
 
 		 These sysfs values expose the TIOCGSERIAL interface via
 		 sysfs rather than via ioctls.
@@ -96,7 +97,8 @@ What:		/sys/class/tty/ttyS<x>/closing_wait
 Date:		October 2012
 Contact:	Alan Cox <alan@linux.intel.com>
 Description:
-		 Show the close wait time for this port in ms.
+		 Show the close wait time for this port in hundredths of
+		 a second.
 
 		 These sysfs values expose the TIOCGSERIAL interface via
 		 sysfs rather than via ioctls.
@@ -166,7 +168,8 @@ What:		/sys/class/tty/ttyACM0/close_delay
 Date:		August 2023
 Contact:	linux-usb@vger.kernel.org
 Description:
-		Set the closing delay time for this port in ms.
+		Set the closing delay time for this port in hundredths of a
+		second.
 
 		These sysfs values expose the TIOCGSERIAL interface via
 		sysfs rather than via ioctls.
@@ -175,7 +178,8 @@ What:		/sys/class/tty/ttyACM0/closing_wait
 Date:		August 2023
 Contact:	linux-usb@vger.kernel.org
 Description:
-		Set the close wait time for this port in ms.
+		Set the close wait time for this port in hundredths of a
+		second.
 
 		These sysfs values expose the TIOCGSERIAL interface via
 		sysfs rather than via ioctls.
-- 
2.37.0

-- 
Simon Arlott

