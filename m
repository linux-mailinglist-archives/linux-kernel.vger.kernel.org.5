Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E57C80EE3A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376405AbjLLOBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376391AbjLLOBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:01:05 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CCBCD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:01:10 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7b6fa79b547so338087239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1702389670; x=1702994470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=50USpyDw1BzfC5HC+GbOK7tULHOIxS4MMTe1pZHKtgw=;
        b=Xf1393alswEqIUVzTHhuw98VS2zGfaKW/RekwLZiLerWyaKZSEmX386DpNLc3f0y11
         h0bOgn0ehabfkmqtsoqG96TKNa8kkI6QCLc7CHtUFL2JCb03O2r33FVFLNjyEkmOwZcH
         +8I+h2RWVEiG8Ihde70DvAg6rXMe/VWsTPXM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702389670; x=1702994470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50USpyDw1BzfC5HC+GbOK7tULHOIxS4MMTe1pZHKtgw=;
        b=TlG3mZGAHfNLjvJNG/stJZKx+pxP5fwpNogwsJ8k78iKCq+g4FdWPPqH8b1E75tDK8
         s5e8k1LzgxpwQ9teaAXY3i/aIEqIZaH5v2gYpTLnCT8cLVVpx0m4Scnj7Oi6GmwXX1wF
         hDdrUbnrjlr/qQ1M34sylMLc2ATOb823rrgNgobtZxsx8YekJQfFxRl0P1Yxvvhd8aOc
         jY0QHHMPhvUMah2TSMs3TsyTEGX2v2B+8BeP3Py7Oe1Bmtl+PlogkkBDh5cz9/7itlsd
         in4FjNyQUr1u1stNc4voLsOrMFjkezHngwdwpAABTXjMyCH8EzdZWMHlxIjZIBq75HpR
         wXgw==
X-Gm-Message-State: AOJu0YxJP7Bk2mlUtB3OuzLRK5XTqQSXGHywR938QKxYnNkPWxyVl6k6
        8yAjXyK33IT5NIjmb7+Zu+Tihw==
X-Google-Smtp-Source: AGHT+IGyL6ZY6hdOyOvfyj+HiZxWufZFo0Xq+Zb+kkzPvrXDz3dkWQvMrhwlUoHPwUGxmgTeTeONoA==
X-Received: by 2002:a6b:fb0a:0:b0:7b7:70b0:5dd6 with SMTP id h10-20020a6bfb0a000000b007b770b05dd6mr245922iog.34.1702389669618;
        Tue, 12 Dec 2023 06:01:09 -0800 (PST)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id w12-20020a056602034c00b007b45c1015b6sm2707078iou.31.2023.12.12.06.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 06:01:09 -0800 (PST)
Message-ID: <786e357b-df63-42bb-bc8a-b5fc8d6e9146@ieee.org>
Date:   Tue, 12 Dec 2023 08:01:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/1] greybus: gb-beagleplay: Remove use of pad bytes
Content-Language: en-US
To:     Ayush Singh <ayushdevel1325@gmail.com>,
        greybus-dev@lists.linaro.org
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, jkridner@beagleboard.org, nm@ti.com,
        yujie.liu@intel.com
References: <20231211065420.213664-1-ayushdevel1325@gmail.com>
 <20231211065420.213664-2-ayushdevel1325@gmail.com>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <20231211065420.213664-2-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 12:54 AM, Ayush Singh wrote:
> Make gb-beagleplay greybus spec compliant by moving cport information to
> transport layer instead of using `header->pad` bytes.
> 
> Greybus HDLC frame now has the following payload:
> 1. le16 cport
> 2. gb_operation_msg_hdr msg_header
> 3. u8 *msg_payload
> 
> Fixes: ec558bbfea67 ("greybus: Add BeaglePlay Linux Driver")
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>

I would say that this is an improvement, but I wish I
had a better picture in mind of how this works.  The
initial commit provided some explanation, but even
there it talks about the "CC1352 (running SVC Zephyr
application)" and that leads me to wonder even how
the hardware is structured.  (I'm not really asking
you for this right now, but you have a reference to
something that provides some background, you should
provide it for context.)

Another general comment is that the use of HDLC seems
like it could be a more clearly separated layer that
could be used by other Greybus protocols or applications.
Maybe that's overkill, but it is a distinct layer, right?

I had a comment or two about using (void *) instead of
(u8 *), to reduce the need for explicit type casts.  But
I found that (u8 *) is used elsewhere in the Greybus code.

One comment I *will* share is that the serdev RX callback
has a const receive buffer.  I recommend you preserve that
"constness" in your code.

					-Alex

> ---
>   drivers/greybus/gb-beagleplay.c | 55 ++++++++++++++++++++++++---------
>   1 file changed, 41 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
> index 1e70ff7e3da4..82dc8a25e6b9 100644
> --- a/drivers/greybus/gb-beagleplay.c
> +++ b/drivers/greybus/gb-beagleplay.c
> @@ -85,17 +85,31 @@ struct hdlc_payload {
>   	void *buf;
>   };
>   
> +/**
> + * struct hdlc_greybus_frame - Structure to represent greybus HDLC frame payload
> + *
> + * @cport: cport id
> + * @hdr: greybus operation header
> + * @payload: greybus message payload
> + *
> + * The HDLC payload sent over UART for greybus address has cport preappended to greybus message
> + */
> +struct hdlc_greybus_frame {
> +	__le16 cport;
> +	struct gb_operation_msg_hdr hdr;
> +	u8 payload[];
> +} __packed;
> +
>   static void hdlc_rx_greybus_frame(struct gb_beagleplay *bg, u8 *buf, u16 len)
>   {
> -	u16 cport_id;
> -	struct gb_operation_msg_hdr *hdr = (struct gb_operation_msg_hdr *)buf;
> -
> -	memcpy(&cport_id, hdr->pad, sizeof(cport_id));
> +	struct hdlc_greybus_frame *gb_frame = (struct hdlc_greybus_frame *)buf;
> +	u16 cport_id = le16_to_cpu(gb_frame->cport);
> +	u16 gb_msg_len = le16_to_cpu(gb_frame->hdr.size);
>   
>   	dev_dbg(&bg->sd->dev, "Greybus Operation %u type %X cport %u status %u received",
> -		hdr->operation_id, hdr->type, le16_to_cpu(cport_id), hdr->result);
> +		gb_frame->hdr.operation_id, gb_frame->hdr.type, cport_id, gb_frame->hdr.result);
>   
> -	greybus_data_rcvd(bg->gb_hd, le16_to_cpu(cport_id), buf, len);
> +	greybus_data_rcvd(bg->gb_hd, cport_id, (u8 *)&gb_frame->hdr, gb_msg_len);
>   }
>   
>   static void hdlc_rx_dbg_frame(const struct gb_beagleplay *bg, const char *buf, u16 len)
> @@ -336,10 +350,23 @@ static struct serdev_device_ops gb_beagleplay_ops = {
>   	.write_wakeup = gb_tty_wakeup,
>   };
>   
> +/**
> + * gb_message_send() - Send greybus message using HDLC over UART
> + *
> + * @hd: pointer to greybus host device
> + * @cport: AP cport where message originates
> + * @msg: greybus message to send
> + * @mask: gfp mask
> + *
> + * Greybus HDLC frame has the following format:
> + * 1. le16 cport
> + * 2. gb_operation_msg_hdr msg_header
> + * 3. u8 *msg_payload
> + */
>   static int gb_message_send(struct gb_host_device *hd, u16 cport, struct gb_message *msg, gfp_t mask)
>   {
>   	struct gb_beagleplay *bg = dev_get_drvdata(&hd->dev);
> -	struct hdlc_payload payloads[2];
> +	struct hdlc_payload payloads[3];
>   	__le16 cport_id = le16_to_cpu(cport);
>   
>   	dev_dbg(&hd->dev, "Sending greybus message with Operation %u, Type: %X on Cport %u",
> @@ -348,14 +375,14 @@ static int gb_message_send(struct gb_host_device *hd, u16 cport, struct gb_messa
>   	if (le16_to_cpu(msg->header->size) > RX_HDLC_PAYLOAD)
>   		return dev_err_probe(&hd->dev, -E2BIG, "Greybus message too big");
>   
> -	memcpy(msg->header->pad, &cport_id, sizeof(cport_id));
> -
> -	payloads[0].buf = msg->header;
> -	payloads[0].len = sizeof(*msg->header);
> -	payloads[1].buf = msg->payload;
> -	payloads[1].len = msg->payload_size;
> +	payloads[0].buf = &cport_id;
> +	payloads[0].len = sizeof(cport_id);
> +	payloads[1].buf = msg->header;
> +	payloads[1].len = sizeof(*msg->header);
> +	payloads[2].buf = msg->payload;
> +	payloads[2].len = msg->payload_size;
>   
> -	hdlc_tx_frames(bg, ADDRESS_GREYBUS, 0x03, payloads, 2);
> +	hdlc_tx_frames(bg, ADDRESS_GREYBUS, 0x03, payloads, 3);
>   	greybus_message_sent(bg->gb_hd, msg, 0);
>   
>   	return 0;

