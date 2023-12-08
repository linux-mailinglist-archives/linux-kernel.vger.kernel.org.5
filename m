Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBA9809E0C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573291AbjLHIWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbjLHIWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:22:06 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D1B172B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:22:11 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d0c94397c0so13806515ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 00:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702023731; x=1702628531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZB3VLtXDWaSMaOTo1FiSlMXHqm5+b+9a5ub3BO89z4=;
        b=T8+MOSYFCKxG+2fgQ0CQF3BEqRjCxui48scHL4UpAVqK0iJKcVCnnv/2E98Rwwbs7I
         PqAtR9iDJjtpbL4vP97JfU11kJ7Ju+4uupVDE/x0ffpl/4PiKLHVRFIM3IOYY0JqjEWz
         7XbDiTpnO1y1yz2WX9PDk5SvA2ygSFZgZloy8GBOS4tlwwbBa6ZzoJYRA8BaCrY7OVJG
         N2BL9+bhbpQn5qZNINipIyVekqrsH+m5MZN/kNu+PhhCTwY7AA/rEILqRpxfzCAsKyFj
         0h04fMY8Gu/ldtbOEIHT7SETWOLsg2uJUQZssT8TXOd42wnHu3DwY6i4Or4te2ShMfYi
         Y34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702023731; x=1702628531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZB3VLtXDWaSMaOTo1FiSlMXHqm5+b+9a5ub3BO89z4=;
        b=akr9yUz2JLLSLHgM3BX2yqKde0hBUfnN5YSZU4v5kCFDkreZ5baKOZIe4oOAUrJ1kf
         h5TqQ90PbXQ0uRVLeML1DHfqjoWmqGzMf1buLeQsA3pzip+iNY8RNwyyAT/8tEmyfjw4
         897temnJ8+wOObbx/kdI/KhEu8iGLDQWtjXEM+o/f3XJgSmK9aRg+WxJVoUpurW/OqPZ
         IRv0Eyg3UG1rErpUDL4S4YHu4c0qvJvd+yLnzZGYfL2L+oRpQlTAALTeWIxNHps6b6QA
         LeRCLgLNusQ3Rw/hAHfH2PBzc1poH/riaHhDyIupei87Y6nWzE9n/QZIUaeC47dO+N2M
         kQhw==
X-Gm-Message-State: AOJu0Yz6Eh2GUPMiVC261WldQiKe1px/2qDvXqlOwhi9af7oYy2fcYju
        TLb8cGgw2VOtUPHgy1YjxvM=
X-Google-Smtp-Source: AGHT+IEwgodN/a4UP4l22QNrk4yK0Y694N+zXeDF+v/G+X6i33chicM7XZMRBGXU485HiB36yI/mtA==
X-Received: by 2002:a17:902:d2c1:b0:1ce:5b93:1596 with SMTP id n1-20020a170902d2c100b001ce5b931596mr4099361plc.5.1702023730976;
        Fri, 08 Dec 2023 00:22:10 -0800 (PST)
Received: from ?IPV6:2401:4900:5aa5:8033:d346:47e3:6a7f:374d? ([2401:4900:5aa5:8033:d346:47e3:6a7f:374d])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902ea0e00b001c88f77a156sm1094407plg.153.2023.12.08.00.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 00:22:10 -0800 (PST)
Message-ID: <6cfbd32b-beb5-49b7-8116-cf95e11586b3@gmail.com>
Date:   Fri, 8 Dec 2023 13:52:05 +0530
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
 <c0823649-8235-40d7-813e-8a4500251219@gmail.com>
 <2023120805-endocrine-conflict-b1ff@gregkh>
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <2023120805-endocrine-conflict-b1ff@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/23 11:03, Greg KH wrote:

> On Thu, Dec 07, 2023 at 10:33:54PM +0530, Ayush Singh wrote:
>>>> + *
>>>> + * @cport: cport id
>>>> + * @hdr: greybus operation header
>>>> + * @payload: greybus message payload
>>>> + */
>>>> +struct hdlc_greybus_frame {
>>>> +	__le16 cport;
>>>> +	struct gb_operation_msg_hdr hdr;
>>>> +	u8 payload[];
>>>> +} __packed;
>>>> +
>>>>    static void hdlc_rx_greybus_frame(struct gb_beagleplay *bg, u8 *buf, u16 len)
>>>>    {
>>>> -	u16 cport_id;
>>>> -	struct gb_operation_msg_hdr *hdr = (struct gb_operation_msg_hdr *)buf;
>>>> +	struct hdlc_greybus_frame *gb_frame = (struct hdlc_greybus_frame *)buf;
>>>> +	u16 cport_id = le16_to_cpu(gb_frame->cport);
>>>> -	memcpy(&cport_id, hdr->pad, sizeof(cport_id));
>>>> +	/* Ensure that the greybus message is valid */
>>>> +	if (le16_to_cpu(gb_frame->hdr.size) > len - sizeof(cport_id)) {
>>>> +		dev_warn_ratelimited(&bg->sd->dev, "Invalid/Incomplete greybus message");
>>> Don't spam the kernel log for corrupted data on the line, that would be
>>> a mess.  Use a tracepoint?
>>>
>>>> +		return;
>>>> +	}
>>>>    	dev_dbg(&bg->sd->dev, "Greybus Operation %u type %X cport %u status %u received",
>>>> -		hdr->operation_id, hdr->type, le16_to_cpu(cport_id), hdr->result);
>>>> +		gb_frame->hdr.operation_id, gb_frame->hdr.type, cport_id, gb_frame->hdr.result);
>>> Better yet, put the error in the debug message?
>> Shouldn't corrupt data be a warning rather than debug message, since it
>> indicates something wrong with the transport?
> Do you want messages like that spamming the kernel log all the time if a
> network connection is corrupted?
>
> Just handle the error and let the upper layers deal with it when the
> problem is eventually reported to userspace, that's all that is needed.

Ok

>>>> -	greybus_data_rcvd(bg->gb_hd, le16_to_cpu(cport_id), buf, len);
>>>> +	greybus_data_rcvd(bg->gb_hd, cport_id, &buf[sizeof(cport_id)],
>>> Fun with pointer math.  This feels really fragile, why not just point to
>>> the field instead?
>> It seems that taking address of members of packed structures is not valid.
> That feels really odd.
>
>> I get the `address-of-packed-member` warnings. Is it fine to ignore
>> those in kernel?
> What error exactly are you getting?  Packed or not does not mean
> anything to the address of a member.  If it does, perhaps you are doing
> something wrong as you are really doing the same thing here, right?
> Don't ignore the warning by open-coding it.

So, the error I was getting was `taking address of packed member of 
'gb_frame' may result in an unaligned pointer value`. I can no longer 
reproduce the warning, though. I think I accidentally fixed the reason 
somewhere along the line.

>>>>    }
>>>>    static void hdlc_rx_dbg_frame(const struct gb_beagleplay *bg, const char *buf, u16 len)
>>>> @@ -339,7 +357,7 @@ static struct serdev_device_ops gb_beagleplay_ops = {
>>>>    static int gb_message_send(struct gb_host_device *hd, u16 cport, struct gb_message *msg, gfp_t mask)
>>>>    {
>>>>    	struct gb_beagleplay *bg = dev_get_drvdata(&hd->dev);
>>>> -	struct hdlc_payload payloads[2];
>>>> +	struct hdlc_payload payloads[3];
>>> why 3?
>>>
>>> It's ok to put this on the stack?
>> Well, the HDLC payload is just to store the length of the payload along with
>> a pointer to its data. (kind of emulate a fat pointer). The reason for doing
>> it this way is to avoid having to create a temp buffer for each message when
>> sending data over UART (which was done in the initial version of the
>> driver).
> Be careful, are you SURE you are allowed to send stack-allocated data?
> I know that many busses forbid this (like USB).  So please check to be
> sure that this is ok to do, and that these are not huge structures that
> you are putting on the very-limited kernel-stack.

Well, the greybus operation header and greybus message are not on the 
stack (as far as I know, since they are inputs to the function). The 
memory that is stack allocated for hdlc_payload array is `3 * 
(sizeof(u16) + sizeof(void *))`, i.e. 30 bytes for 64 bit pointers 
(ignoring any padding). So I don't think the size of hdlc_payload array 
should be an issue.

The function `hdlc_tx_frames(bg, ADDRESS_GREYBUS, 0x03, payloads, 3);` 
actually copies the data to a different circ_buf, which is sent later by 
workqueue. So the final data sent is not stack allocated. In fact, none 
of the data from this function is going to be referenced after the call 
to `hdlc_tx_frames`.


Ayush Singh

