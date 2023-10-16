Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3257CAE69
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjJPQBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJPQBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:01:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA670AB;
        Mon, 16 Oct 2023 09:01:47 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso7225497a12.3;
        Mon, 16 Oct 2023 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697472106; x=1698076906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jRF4V//IfL34HKZqTHCNTkMx2RDpGpAIjYdpbZ1Yyig=;
        b=aolKb0QYM7T8F0/5cqy83iqumABt6aryvQKSRFRjfroNTuDMXcyVGwGS/88M51Jsc6
         LVnnLUUJxOr+WwBhBeB7O2cuJ5KYgW3vLRakWTNHeAFCd9M99kmBgVEYkYIDfO/5pPEt
         R73Vjcu5q7aNC8/inzESP2F0ZjxS5xYPdXRb0iTjT1+one2FTQ0OzaqgylCd/fUkhRpA
         +a+hiCaYFusguri2XE8lpJgnMX+jzdkHNdi42xBX82aEF5Jx1urFE8346CdDFTz1lgJ8
         9IJ2gfi32MK98PdQiNJpK0r1EjlaMlP4mEuntdApSSF0oxwiHITM9JIOqVfY+0OjlxjO
         TjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697472106; x=1698076906;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRF4V//IfL34HKZqTHCNTkMx2RDpGpAIjYdpbZ1Yyig=;
        b=SzGdiOqTFAg/4cMdusIC+Q/d+ogotztQq/3nZzqEA7GWDnlb0C/ysMP1MahKEqfaUF
         sbrM4s1glf6p1QbF+X707g6TadVm21bSAI3hidEUpzqOzj/pmsLWyQBRSjfgUm8o+x8G
         JDhUPw66mo2wDWbu7AqQ8aCDIihFOIem4h3WwnxOsG5p8136sam99mfd11BCrLyX0pp0
         W/dQMlS/ly9EOMCpDz8IHQKw3HtWUWfoBtWa1CL5v50JUF6J/a9aLNSsq3TJtN24onG1
         42Jd6fm7lnlV7d+vuLjBURU8gLm5rkMK/DDCvCUPLgm6uF5ug+1G7Po/ZVhzzh4Oqo70
         TEQA==
X-Gm-Message-State: AOJu0YzqE9NugyqjHBNO+drbn7qy9GKy114shPGzcQmO7VLjrKAdrg/0
        iN+Xw0DyvCftG5+kn6MFqZQ=
X-Google-Smtp-Source: AGHT+IHgOQZBI7x+iBRVMoiqy2UPPDqib1RcXHtiuc5JAeiib4FbazaRE4ZauD8////n8Z3L3VILjQ==
X-Received: by 2002:a05:6402:50cd:b0:53e:3d9f:3c72 with SMTP id h13-20020a05640250cd00b0053e3d9f3c72mr8925654edb.18.1697472105968;
        Mon, 16 Oct 2023 09:01:45 -0700 (PDT)
Received: from [192.168.2.30] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id dm28-20020a05640222dc00b0053dec545c8fsm82874edb.3.2023.10.16.09.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 09:01:45 -0700 (PDT)
Message-ID: <f71b5c39-5499-4ae8-99e2-fb679f0b6a11@gmail.com>
Date:   Mon, 16 Oct 2023 18:01:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: use ATA-12 pass-thru for OPAL as fallback
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <dlemoal@kernel.org>, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org
References: <20231016070211.39502-1-gmazyland@gmail.com>
 <20231016070531.GA28537@lst.de>
 <bf4d0580-62b1-4959-8fc4-a7ab86b7e980@gmail.com>
 <0c7f0599-40de-417a-842d-d0aba842d115@kernel.org>
 <5831286b-e3d0-4b87-9c5c-dbcb420d1b67@gmail.com>
 <20231016132730.GA27013@lst.de>
From:   Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20231016132730.GA27013@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 15:27, Christoph Hellwig wrote:
> On Mon, Oct 16, 2023 at 02:46:03PM +0200, Milan Broz wrote:
>> The problem is that we (for simplicity) decided to use kernel SED-ioctl interface that
>> internally wraps OPAL command to SCSI SECURITY command only. It means, that all devices
> 
> No, it doesn't.  It uses the properly specified protocol for each
> layer.  That is NVMe uses NVMe Security Send/Receive, SCSI uses the
> SCSI protocol, and libata translats for ATA devices.
> 
>> that can use ATA-12 just cannot work with this kernel interface (unlike userspace which
>> can decide which wrapper to use).
> 
> It supports all devices that actually speak ATA perfectly fine, take
> a look at ata_scsi_security_inout_xlat.

Yes, I have several of them in my test machine. The comment was about (S)ATA connected
through USB bridge only.
  
>>
>> And IMO it is not correct - if it was designed only for some servers with directly connected
>> devices, then it is really not generic OPAL support. It should work for any hw that supports it.
> 
> Let's get off your crack pipe before we continue.  It is designed and
> implemented to support the security protocols exactly as spec'ed.
> 
> You seem to have found devices that claim to be SCSI, but actually
> require ATA passthrough for security.  That's no secret cabal to lock
> out non-server hardware but just proper protocol design.

*grin* I just bought several NVMe to USB adapters that presents NVMe device as SCSI, this
is pretty common.

(And Thunderbolt adapters - that present NMVe as real NVMe is another story too.
But once configured, it is doing it correctly.)

But yes, you are right - except the USB hw is here (in huge quantities) and I want to use it.
It is quite possible that there is not way to do it clearly - fine, that's why I sent the patch
for review.

> 
>> For USB, it actually works quite nice with the patch (ignoring usual bugs in firmware).
> 
> So move it into usb if you can convince the usb maintainers that they
> are fine with it.

Yep, fair enough. My initial motivation was just understand WTF is going there.
Put the support on a proper layer is step #2.

>>> Note that nowhere in your patch do you test if you are talking to an ATA device.
>>
>> Yes, I know. I expected the command to be rejected if not supported.
> 
> Good luck.  Cheap storage hardware trips up on unknown commands all the
> time.

... And my tests for TCG OPAL commands shows that it can be even worse on this layer :-)
(To be fair, recent NVMe devices looks much better. Anyway, yes, I know what you mean.)

> 
>> IMO it is quite similar to discard/TRIM support...
> 
> Where we also don't support weird ATA commands directly from sd
> for good reason.

ok, I am actually quite happy that I get some response to this patch.
Supporting it is a mess, but I still believe we can do it (if fw is not completely bogus).

Thanks,
Milan
