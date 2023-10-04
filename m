Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1617B8CF4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245216AbjJDS7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244831AbjJDS5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:57:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0144C19A3;
        Wed,  4 Oct 2023 11:55:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D78AC4339A;
        Wed,  4 Oct 2023 18:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445701;
        bh=G5QCsBxCk9eibNWxIf6ck3SmhlHV2fYc1B9TJdB/V9o=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=nBhiDQjI/Y86QtC68JzXeOswi/z6hKnf9IJxkvPK5hF1muB0sOkBEFk8Pt2lqD87J
         pi4b71LVP4jzyNPErNynNDW12amBVTqTCJtRISP4LiJybeNg5BFSxO8PQ/QvcmCCv1
         pZSVUu7/1wNCGTrjoja1MW9CgzIk2UQu/QH+xkYa1oxiXe68o/FXL4YfDGpE+Kccex
         nMCc00qDrI47Jvh1y3IsvpNfk1B3PtEOrYIEiwJcBRMaUqf9ezG/2yQVgO1ipirsDl
         VRRmF2iA44MvXylP5NJc5/ChsOFrDCw5GSCsuP89YE66cebmh3Cxe2ZNA459MTuW8l
         judFcTDi636+w==
Date:   Wed, 4 Oct 2023 20:54:57 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Rahul Rameshbabu <sergeantsagara@protonmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rain <rain@sunshowers.io>
Subject: Re: [PATCH] HID: multitouch: Add required quirk for Synaptics 0xcd7e
 device
In-Reply-To: <20230917161802.39716-1-sergeantsagara@protonmail.com>
Message-ID: <nycvar.YFH.7.76.2310042054390.3534@cbobk.fhfr.pm>
References: <20230917161802.39716-1-sergeantsagara@protonmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Sep 2023, Rahul Rameshbabu wrote:

> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multi
> touch.c
> index 521b2ffb4244..8db4ae05febc 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -2144,6 +2144,10 @@ static const struct hid_device_id mt_devices[] = {
> 			USB_DEVICE_ID_MTP_STM)},
> 
> 	/* Synaptics devices */
> +	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
> +		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
> +			USB_VENDOR_ID_SYNAPTICS, 0xcd7e) },
> +
> 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
> 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

