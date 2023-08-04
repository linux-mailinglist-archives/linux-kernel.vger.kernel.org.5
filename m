Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D71876FAD3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbjHDHLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjHDHLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:11:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF13346B3;
        Fri,  4 Aug 2023 00:10:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AA9861F52;
        Fri,  4 Aug 2023 07:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612EAC433C8;
        Fri,  4 Aug 2023 07:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691133040;
        bh=62KxXbPq/v9mVt89IWvhNC7HqQ/Vf5hkkkSHvyM2294=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=EdBv1zzbSPBpUuAo7GeIIIR34w57JYjlIsm68aTkXnfGHjDXD+q6zFo/VqsURUKXM
         s+KRf43zRQR+D0PEZab22S3QFVNOeUr89tDHeOGcogDk7L1rhCCgsOBPQcIRWkASyO
         i0WHWZ3V2PNGKz8yOWyB4BWEJQuHvQF/trJ7JmKspmbSc3vxgRCnBppHSXNYZ5Ek8U
         UyRkA0bHSDDPr7lqz3ZMiqInK96cburfsTIyJcrETbV5VtCNzSO3hSLyf8+E9lMQIF
         ta9PAX7CUYYhZRPH0ioriboTKBfIDaMOGlWcDaDH82gfsEZL39n8Jeiu33BttOY81g
         P8zbObTzQDcew==
From:   Kalle Valo <kvalo@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Atul Raut <rauji.raut@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ath6kl: replace one-element array with
 flexible-array member
References: <20230804045554.6934-1-rauji.raut@gmail.com>
        <2023080433-patio-staining-2cfe@gregkh>
Date:   Fri, 04 Aug 2023 10:10:37 +0300
In-Reply-To: <2023080433-patio-staining-2cfe@gregkh> (Greg KH's message of
        "Fri, 4 Aug 2023 07:15:43 +0200")
Message-ID: <87sf8zs2oi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:

> On Thu, Aug 03, 2023 at 09:55:54PM -0700, Atul Raut wrote:
>
>> One-element arrays are no longer relevant, and their
>> place has been taken by flexible array members thus,
>> use a flexible-array member to replace the one-element
>> array in struct ath6kl_usb_ctrl_diag_cmd_write
>> 
>> This fixes warnings such as:
>> ./drivers/net/wireless/ath/ath6kl/usb.c:109:8-12: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
>> 
>> Signed-off-by: Atul Raut <rauji.raut@gmail.com>
>> ---
>>  drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
>> index 5220809841a6..c8ecc9e85897 100644
>> --- a/drivers/net/wireless/ath/ath6kl/usb.c
>> +++ b/drivers/net/wireless/ath/ath6kl/usb.c
>> @@ -106,7 +106,7 @@ struct ath6kl_usb_ctrl_diag_cmd_write {
>>  	__le32 cmd;
>>  	__le32 address;
>>  	__le32 value;
>> -	__le32 _pad[1];
>> +	__le32 _pad[];
>
> Are you sure this is actually a variable length array?

It's not, it's just padding. We both told this in v1:

https://patchwork.kernel.org/project/linux-wireless/patch/20230731012941.21875-1-rauji.raut@gmail.com/

> And you just changed the size of this structure, are you sure this is
> correct?

This patch is not correct.

Atul, ALWAYS include a changelog when submitting a new version. Please
carefully read our wiki link below before submitting new patches to
wireless.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
