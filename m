Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B10578A0F1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 20:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjH0SXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 14:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjH0SXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 14:23:53 -0400
Received: from genua.uuid.uk (genua.uuid.uk [78.47.120.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DAB120;
        Sun, 27 Aug 2023 11:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20230424-rsa3072; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:
        Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=FtgBnnbL7InHN0jz7NDy+yS0z9cLS5ehECtcuFj7NI8=; t=1693160629; 
        b=jFXVsHeuWUypCkn+vlI7akwk0isDuZFC9Kul9f2mVBOxmiUCiqqNY7lpbdBP/8vWAHfR7Xz1OOv
        pRMGsVljjZNde6dirtgeNUM0Ha1ri2oXBLXPCKIrC9X3isgZoWIfWh9iQJpTnNu3ZjvZElZ4UX25U
        zgvpUVjphPSFMn3O+9O2+Pi2Ur0V3qLbtoKP/c9+v+mJbUGsAct3QYxcjGy6jtJx3yakrid5Fpae/
        TA66FSiLz25IloP3n28pxYIedicq5f3aekWgDKojlnRGqKR+NlxlX7d/RsOzPnPGX1IPNVAVDXNNz
        dH5urQ3y6nZpdOZkLrw8MzNPasiMAfN39d41VCHC0QSKa2s0Z/OqwyEyq1I9zLrKGdtVWRk1esoa3
        TKGbIMPS8yWLYZuQ3KHhB23tH0ZumVzAQhcmHiSfeh/rVjdBQFLyZtLYChnhYYOvo0IK1X90YB+mq
        IhTcDkl7pjkxsyYvdwXnJPpDJ/JkxD+Jg6SvjvW2puuajL03jdFP;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
        d=octiron.net; s=20230410-ed25519; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=FtgBnnbL7InHN0jz7NDy+yS0z9cLS5ehECtcuFj7NI8=; t=1693160629; 
        b=+WecUCb4yupXf6AmgzkmpTW/akp/RwiMdDtAkf3dkTGE7E+cVnEuJS+yQ9Khw4Aoap4NZbR/rng
        P4PF5mDvNDg==;
Received: by genua.uuid.uk with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <simon@octiron.net>)
        id 1qaKQI-00DZDH-64; Sun, 27 Aug 2023 19:23:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20230424-rsa3072; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:
        Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=FtgBnnbL7InHN0jz7NDy+yS0z9cLS5ehECtcuFj7NI8=; t=1693160622; 
        b=MYH7qwdfcLoebqtX3yvGI+Wiv8BTc3NPMTcaT9hGhFdfxvxpSc7PYSnmcYtebr+DMEIJm0lCJlS
        YEcghtB5OUzQ57KHGdj4Wm2yyN7xaCUlLbQKa/AZ9xMRZi3gwKRhA1mqP/IhBebJLhgIDw/baYPM3
        29xzX2FFP/u1LmlzfybPoKncpoGZ10+BsZBwQQ0qSJmcIzupYqjZMRyLWn9CEVQ+dgBwE4zDl4enV
        ZNm0uZg9pZjRoaj+QMFwtjWvNbXx50I6A0i9eLWrzfu/CoSDiGPGaYGejuH88QIysoqWikE4jjeHr
        R9BwZpa0FPic7AuzWLH+nZUpIL88sFuNqua9gi4IHLwBgV+AHiDAQ6fP9IALwB7v6k6A3jKjY3Ygn
        VkeQo7qOjWBQUqJD1j5/LfEjkxB3wbe3YiQ5u0LdpKZvfw9HtyHWY/ZMx37NTYu+oFaC1kHycW+x8
        IY/l6wsP4UeeMh3fvDuGuSoRDyq4HIHNRKpCvd0cpENHt5/CtwO4;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
        d=octiron.net; s=20230410-ed25519; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:Bcc:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To:References:
        Organization; bh=FtgBnnbL7InHN0jz7NDy+yS0z9cLS5ehECtcuFj7NI8=; t=1693160622; 
        b=WcSQfzUwB3bUzrIds1MFcqXOEr6tGSjvefGBhOwD1Uq5mUEPMKow7fyBRfAVxR0EJo9OgmW5QUk
        YYwZ9LUkfAg==;
Received: by tsort.uuid.uk with esmtps (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.93)
        (envelope-from <simon@octiron.net>)
        id 1qaKQF-005zuY-UE; Sun, 27 Aug 2023 19:23:40 +0100
Message-ID: <30fa035a-709f-58cd-fc1e-fef1367dc6dd@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
Date:   Sun, 27 Aug 2023 19:23:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: [PATCH (v2)] docs: ABI: sysfs-tty: close times are in centiseconds
Content-Language: en-GB
To:     Jiri Slaby <jirislaby@kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <ea1a13ad-a1e0-540a-e97a-4c44f6d2d33b@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
 <40c5c70f-46ff-c5f3-212b-2badc47e49a3@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
 <27304225-c8b0-9cac-94a3-e985e45aa41a@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
 <2a3647bf-91a8-7a5f-9edb-c792a6031f57@kernel.org>
From:   Simon Arlott <simon@octiron.net>
X-Face: -|Y&Xues/.'(7\@`_\lFE/)pw"7..-Ur1^@pRL`Nad5a()6r+Y)18-pi'!`GI/zGn>6a6ik
 mcW-%sg_wM:4PXDw:(;Uu,n&!8=;A<P|QG`;AMu5ypJkN-Sa<eyt,Ap3q`5Z{D0BN3G`OmX^8x^++R
 Gr9G'%+PNM/w+w1+vB*a($wYgA%*cm3Hds`a7k)CQ7'"[\C|g2k]FQ-f*DDi{pU]v%5JZm
In-Reply-To: <2a3647bf-91a8-7a5f-9edb-c792a6031f57@kernel.org>
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

The times for close_delay and closing_wait are in centiseconds, not
milliseconds. Fix the documentation and add details of special values.

Signed-off-by: Simon Arlott <simon@octiron.net>
---
On 25/08/2023 06:33, Jiri Slaby wrote:
> And I would use "centiseconds" instead, which is used (IMO) in these cases.

It's used in a few places, but the documentation has no "centiseconds"
and a couple of "hundredths". I've changed it anyway.

 Documentation/ABI/testing/sysfs-tty | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-tty b/Documentation/ABI/testing/sysfs-tty
index 820e412d38a8..895c47f05f6f 100644
--- a/Documentation/ABI/testing/sysfs-tty
+++ b/Documentation/ABI/testing/sysfs-tty
@@ -87,19 +87,22 @@ What:		/sys/class/tty/ttyS<x>/close_delay
 Date:		October 2012
 Contact:	Alan Cox <alan@linux.intel.com>
 Description:
-		 Show the closing delay time for this port in ms.
+		Show the closing delay time for this port in centiseconds.
 
-		 These sysfs values expose the TIOCGSERIAL interface via
-		 sysfs rather than via ioctls.
+		These sysfs values expose the TIOCGSERIAL interface via
+		sysfs rather than via ioctls.
 
 What:		/sys/class/tty/ttyS<x>/closing_wait
 Date:		October 2012
 Contact:	Alan Cox <alan@linux.intel.com>
 Description:
-		 Show the close wait time for this port in ms.
+		Show the close wait time for this port in centiseconds.
 
-		 These sysfs values expose the TIOCGSERIAL interface via
-		 sysfs rather than via ioctls.
+		Waiting forever is represented as 0. If waiting on close is
+		disabled then the value is 65535.
+
+		These sysfs values expose the TIOCGSERIAL interface via
+		sysfs rather than via ioctls.
 
 What:		/sys/class/tty/ttyS<x>/custom_divisor
 Date:		October 2012
-- 
2.37.0

-- 
Simon Arlott

