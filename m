Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9275080EED5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376808AbjLLOaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376799AbjLLOay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:30:54 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E96D8E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:30:59 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cea1522303so3510788b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702391458; x=1702996258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLxmEV46v22txwFa1AVF+a9kLvKBmUdsjhpPYXuqg68=;
        b=Nzuk5xoBuyg87U8DesYJog0HMY8y1eg289VHc5gIl1z4tmJsDdGIi3ukQg+u3TTuVa
         ITCp6rS+1P4tbyhYZ3yfxxRraI87l8jgBYUt3HK6XOFoeI+NEAWo3ZcRzR+g1rO6YK8I
         z3LSr855UNol1IGlYR9G5DYSOGoGPCpDO06c6xK6KsRXX2WKkphks1f7JYePRlirrYlu
         QRMouRc2MZwT7rMQ3MzRGyLQb4FgxtcHmBwzeoH5j9R2xEgPTx9omjUDes82rasKJDVl
         zv12GgILId7kLW3hq+yDWjQdU2ECETdLVrr/E0A/eMFcpwbU8GaiBeIzhpAJ0dyI+8cy
         S0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702391458; x=1702996258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLxmEV46v22txwFa1AVF+a9kLvKBmUdsjhpPYXuqg68=;
        b=hNcqQE3mFKZdEBNB8oEstVh9CPjpENPzyG+1pzdpac0QdOB6wPldcUjy/mf2MIjlxh
         tObCwfYx4z77r1kaQOahIlIPe+uYYohEtnpxj6Aja/QdXem+mUEW09iszzXpRQD/D7b6
         qvfY7+GRLywdpJNvvyT6JZc8x/yz8wmf4ul2y/9PLVeGcRDY7l+Phd6MqUbXmkl2xgFv
         8+La2VBw36WRBOLuvyMafWZI7v5su14uyEfeliAVYfKQoEN3sUqj/PI3d3jnOleS6TOd
         4+mE7yBXCsouDAe+FpyU+kVm9tPAHh8sSdoqMnF2f5mg9GG5Z/kmWMqoGSyv/FaYF3DH
         Emsw==
X-Gm-Message-State: AOJu0YwCwWP8+ivF2L8sP2iG+Az6GymArH820+PsY1n1rsoc06qwvJek
        VPZANU3Lz/gF8s9Nil1SlqU=
X-Google-Smtp-Source: AGHT+IFL54CYdCheHswHgye1orgRAHKB3RtZKK/0Uf04FuiqrNkuXtBmj4FcrK3a7VUkrqr9FylNRQ==
X-Received: by 2002:a05:6a20:639e:b0:18f:97c:4f58 with SMTP id m30-20020a056a20639e00b0018f097c4f58mr2188874pzg.100.1702391458310;
        Tue, 12 Dec 2023 06:30:58 -0800 (PST)
Received: from ?IPV6:2406:3003:2007:229e:ac29:68d8:877:4f72? ([2406:3003:2007:229e:ac29:68d8:877:4f72])
        by smtp.gmail.com with ESMTPSA id s24-20020a632158000000b005c67ca3c2c2sm8115302pgm.21.2023.12.12.06.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 06:30:57 -0800 (PST)
Message-ID: <27e768dd-f752-40d8-b4e0-0be34eb1d409@gmail.com>
Date:   Tue, 12 Dec 2023 20:00:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/1] greybus: gb-beagleplay: Remove use of pad bytes
Content-Language: en-US
To:     Alex Elder <elder@ieee.org>, greybus-dev@lists.linaro.org
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, jkridner@beagleboard.org, nm@ti.com,
        yujie.liu@intel.com
References: <20231211065420.213664-1-ayushdevel1325@gmail.com>
 <20231211065420.213664-2-ayushdevel1325@gmail.com>
 <786e357b-df63-42bb-bc8a-b5fc8d6e9146@ieee.org>
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <786e357b-df63-42bb-bc8a-b5fc8d6e9146@ieee.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/12/23 19:31, Alex Elder wrote:
> On 12/11/23 12:54 AM, Ayush Singh wrote:
>> Make gb-beagleplay greybus spec compliant by moving cport information to
>> transport layer instead of using `header->pad` bytes.
>>
>> Greybus HDLC frame now has the following payload:
>> 1. le16 cport
>> 2. gb_operation_msg_hdr msg_header
>> 3. u8 *msg_payload
>>
>> Fixes: ec558bbfea67 ("greybus: Add BeaglePlay Linux Driver")
>> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
>
> I would say that this is an improvement, but I wish I
> had a better picture in mind of how this works.  The
> initial commit provided some explanation, but even
> there it talks about the "CC1352 (running SVC Zephyr
> application)" and that leads me to wonder even how
> the hardware is structured.  (I'm not really asking
> you for this right now, but you have a reference to
> something that provides some background, you should
> provide it for context.)

Yes, I am thinking of revamping the Beagle connect docs to reflect the 
new architecture with some charts and provide a better overall picture. 
It is sorely needed at this point.


> Another general comment is that the use of HDLC seems
> like it could be a more clearly separated layer that
> could be used by other Greybus protocols or applications.
> Maybe that's overkill, but it is a distinct layer, right?

Initial commits of gb-beagleplay did separate all the HDLC parts from 
the driver. However, it was decided to keep it together and maybe 
extract it in the future if other drivers need it.


>
> I had a comment or two about using (void *) instead of
> (u8 *), to reduce the need for explicit type casts.  But
> I found that (u8 *) is used elsewhere in the Greybus code.
>
> One comment I *will* share is that the serdev RX callback
> has a const receive buffer.  I recommend you preserve that
> "constness" in your code.
>
>                     -Alex

The constness of the receive buffer is actually preserved. The 
`gb_tty_receive` function calls `hdlc_rx` (which takes const u8 *). This 
function copies the data to a separate buffer 
(`gb_beagleplay->rx_buffer`) for further processing. So the const data 
is not modified.


Ayush Singh

