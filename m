Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C897808E52
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442822AbjLGRD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLGRD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:03:56 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4E110F1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:04:02 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d0bcc0c313so8368915ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 09:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701968642; x=1702573442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZIcA+9fYzbWnjyGk0GXW0XBB7BmRVEDpCB5UggeUuI=;
        b=MRk3rZMfv/3vTr2vUpimjFjonSLV+AKFxfJT3VcAOofTz/sP0vTU3cEypWpki83N9s
         cUJ6FMKOQ5ju4cmpi7Aln/v1q6k8z3oqhPkCxtRx92c1Gker8p7Tn4iKBJqhNYsckBqK
         FhiesZcjupaYfwipSZmuMIYJ2D520yPmoJmtr+X7t5qdKcs24vcrZJEzEN27r1hy5P1W
         moYOVcU8gSUP2qwLyd7ndOz4Qi/TsvKjjjQ8tOr52LgALXj2E1Sfxz3vLqwJCorpTl0/
         fpycaxnC8Vz/tV3RlAsNRmBNkEli0i+M/HqPWm7Z21zGKFXtmJwGShCr+4NtqppGLeby
         lbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701968642; x=1702573442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZIcA+9fYzbWnjyGk0GXW0XBB7BmRVEDpCB5UggeUuI=;
        b=vKFGEr+iLoSIUpPvisqxfIZUVJO5WI20p9GzX1rbbVjUbEr0rDDEcW6CU6MNPOnYeA
         R7nD/TWayuar5FXqKmOjpl1ziP/+YReD28sVS09Qo5ePCXLsNH9XXUzeQgLokeXIxy2M
         b1ZYUJwdNnbcJBh5q8ig/DBcMnBU2dpFBnnkXnufkznz6D8pvqX/w51+p1CXLd7nTZiz
         kKmqjssNtUoiPKpwyHwxPly0DfwLW2nCYmdTYFknK50iXk1vGPCQZv2AuMPkqT5y989H
         JucygbNoqeOeY/Zhou4VW+CuPiUoAq5tEZxX+SlgnqtBAvE6HXARJBKjA3syV/Fxt5tL
         RO1w==
X-Gm-Message-State: AOJu0YwDEnWjKSHX8ezRfjVsEJxWclGFb+2P6m5W1YDcQHt3KUEFFqV/
        cmE6AcEXwsRb9Xy119jCSJM=
X-Google-Smtp-Source: AGHT+IF1L6MNer4FwLYISwW1U2aCJzS0INHs6Pte/IsYAV0smcVX4K3EDVYM2WEzhgt7VgLKEv/wOw==
X-Received: by 2002:a17:902:6bc5:b0:1d0:6ffd:8354 with SMTP id m5-20020a1709026bc500b001d06ffd8354mr2076131plt.95.1701968642031;
        Thu, 07 Dec 2023 09:04:02 -0800 (PST)
Received: from ?IPV6:2401:4900:51d9:562a:9ec:cd8:a919:e33f? ([2401:4900:51d9:562a:9ec:cd8:a919:e33f])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b001cfc170c0cfsm39772plb.119.2023.12.07.09.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 09:04:01 -0800 (PST)
Message-ID: <c0823649-8235-40d7-813e-8a4500251219@gmail.com>
Date:   Thu, 7 Dec 2023 22:33:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] greybus: gb-beagleplay: Remove use of pad bytes
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, johan@kernel.org, elder@kernel.org,
        linux-kernel@vger.kernel.org, jkridner@beagleboard.org, nm@ti.com,
        yujie.liu@intel.com
References: <20231206150602.176574-1-ayushdevel1325@gmail.com>
 <20231206150602.176574-2-ayushdevel1325@gmail.com>
 <2023120758-coleslaw-unstopped-530c@gregkh>
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <2023120758-coleslaw-unstopped-530c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> + *
>> + * @cport: cport id
>> + * @hdr: greybus operation header
>> + * @payload: greybus message payload
>> + */
>> +struct hdlc_greybus_frame {
>> +	__le16 cport;
>> +	struct gb_operation_msg_hdr hdr;
>> +	u8 payload[];
>> +} __packed;
>> +
>>   static void hdlc_rx_greybus_frame(struct gb_beagleplay *bg, u8 *buf, u16 len)
>>   {
>> -	u16 cport_id;
>> -	struct gb_operation_msg_hdr *hdr = (struct gb_operation_msg_hdr *)buf;
>> +	struct hdlc_greybus_frame *gb_frame = (struct hdlc_greybus_frame *)buf;
>> +	u16 cport_id = le16_to_cpu(gb_frame->cport);
>>   
>> -	memcpy(&cport_id, hdr->pad, sizeof(cport_id));
>> +	/* Ensure that the greybus message is valid */
>> +	if (le16_to_cpu(gb_frame->hdr.size) > len - sizeof(cport_id)) {
>> +		dev_warn_ratelimited(&bg->sd->dev, "Invalid/Incomplete greybus message");
> Don't spam the kernel log for corrupted data on the line, that would be
> a mess.  Use a tracepoint?
>
>> +		return;
>> +	}
>>   
>>   	dev_dbg(&bg->sd->dev, "Greybus Operation %u type %X cport %u status %u received",
>> -		hdr->operation_id, hdr->type, le16_to_cpu(cport_id), hdr->result);
>> +		gb_frame->hdr.operation_id, gb_frame->hdr.type, cport_id, gb_frame->hdr.result);
> Better yet, put the error in the debug message?
Shouldn't corrupt data be a warning rather than debug message, since it 
indicates something wrong with the transport?
>>   
>> -	greybus_data_rcvd(bg->gb_hd, le16_to_cpu(cport_id), buf, len);
>> +	greybus_data_rcvd(bg->gb_hd, cport_id, &buf[sizeof(cport_id)],
> Fun with pointer math.  This feels really fragile, why not just point to
> the field instead?
It seems that taking address of members of packed structures is not 
valid. I get the `address-of-packed-member` warnings. Is it fine to 
ignore those in kernel?
>>   }
>>   
>>   static void hdlc_rx_dbg_frame(const struct gb_beagleplay *bg, const char *buf, u16 len)
>> @@ -339,7 +357,7 @@ static struct serdev_device_ops gb_beagleplay_ops = {
>>   static int gb_message_send(struct gb_host_device *hd, u16 cport, struct gb_message *msg, gfp_t mask)
>>   {
>>   	struct gb_beagleplay *bg = dev_get_drvdata(&hd->dev);
>> -	struct hdlc_payload payloads[2];
>> +	struct hdlc_payload payloads[3];
> why 3?
>
> It's ok to put this on the stack?

Well, the HDLC payload is just to store the length of the payload along 
with a pointer to its data. (kind of emulate a fat pointer). The reason 
for doing it this way is to avoid having to create a temp buffer for 
each message when sending data over UART (which was done in the initial 
version of the driver).

Ayush Singh

