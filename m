Return-Path: <linux-kernel+bounces-131970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092B5898E14
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1A51F227D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA8E130E30;
	Thu,  4 Apr 2024 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XD6J1VhH"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32AF12D775;
	Thu,  4 Apr 2024 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255825; cv=none; b=LoCrS+INIu39y2r98Nf3OBisDQZT72cmtzpih4dyVuw7A6Bfj/lp2VxFpx9fpr6xZqH1g3C6zSUM7M2vyfmRs6JPiCAXzRDMcJA1uf4zQ+z7s47vFC1Y8E1zT0yd6RtJ3i6xsB+PJhAD9SjtH/6K11K5+PTHe7xT9I/KdFp110E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255825; c=relaxed/simple;
	bh=10IvWx0P9NfRBMymY9YlYzDiOxmDJEngcPp/9nn/URw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iiSn6f7UOf4pwwmVWGmnNsPOvUa5M5QQHZ/f8LDQr/n0o9aw08SIzaP0fF1F9tiyiOaviKU+5hcBe+42pwhLv47kiobhMIJS0rNShYViKpfp7x7MXtfn9luWQU7XbUwopemQ2EjgqmI66nxI0+tMySpJUxpw2elLeudC7wpdbO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XD6J1VhH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41550858cabso9102925e9.2;
        Thu, 04 Apr 2024 11:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712255822; x=1712860622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RtbHY0YVM/I5JSJGozTwS/MzIsFQPhKj3IIsO/Nab0M=;
        b=XD6J1VhHbnNFygHq2obHIUfna4SbCKVhUKAqo2K3gYGHqJIyeU5HWpwPxqjeq4C4kq
         F4+DPP7ArHTyeSBHZeq63ruTx+mpeohwHBc2Wr+ZFsoYkj3ANNwEbOs8Rb7Gp7KnRPXw
         Y6mOTU39h0m0+ryAkRnfX1dj4jNIYHgLGl8X6VIErRZ2aWzsHeozhKnh6JEPnaTtuDnd
         H+YNNEwjkdrbMmDSgcFgdzNoqkDd8jWZ7Ig/oWYXFbDjQ76BGBTYkQu7i6qVBaAD2V96
         xEqxtGINUGZFxQGHBo1Me4tinoZSkmZagKck+nftY0IrVQ50qIzhtvmETz2NypciRicV
         amDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712255822; x=1712860622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtbHY0YVM/I5JSJGozTwS/MzIsFQPhKj3IIsO/Nab0M=;
        b=ipzaVP1cELn4pSZdI3xVONOhoQF6itPoATbhaNBrT4CNTLwg/e5FOCI9pV+upz05Vl
         aq5P3CEfzNDVAHfsNOJv5fFSMjwTp+f/Uyih0wbjQwKORVyZMyX0lQpoF1+pYzmKDhyC
         cs2k140/KWSrb4zxPah1vm9eUyZx5dN1sPYNTKXe+YMdrO/5/11dOilqx7BfSXfnfNFg
         Ee2KrT/GcKM4YQ+npLd0EuukB+3dQMMBB4CQS2/k7cfcgExoBEDw/jTMyt4Ib0byqOq5
         TWSOhZDyjjp8Or/lacmAXbVaZPXjdud1lD2r8dLrrhJVqWwZpS+Ru6/x+8L+LhFV0gg/
         ViJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHjeXEvZi8WOhZQaq/x0YOBfkZEOkVAg26ptbgqYdZButjfFqd4M9ddH93xyBZvhA8GX+wJwxchr+n58nZYCQRq/zmQderJ31CCxSHet289qDq07EwNhbrzxnF9MsjzcM8j5WdRcvglu+DDw==
X-Gm-Message-State: AOJu0YyWrKlR0eEZLOm0SZMsrmHNm58RxH5fXGiGwPfI365n4X7+xMLw
	9vDXFiCFJ5UXkCJtzxt1PPQRquFdsCYMNI7yVqilDsOpM60Cur+A
X-Google-Smtp-Source: AGHT+IEWKHqT3JitYA6ObuZeBmVle4pZESaRLdfNnPL+LakBUe9F7gp7fUaWfsvnVnZrG8fX/quaMQ==
X-Received: by 2002:a05:600c:3417:b0:414:6c72:8df with SMTP id y23-20020a05600c341700b004146c7208dfmr2436607wmp.38.1712255821894;
        Thu, 04 Apr 2024 11:37:01 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id d6-20020a05600c34c600b0041547cdfbc7sm4685124wmq.0.2024.04.04.11.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 11:37:01 -0700 (PDT)
Message-ID: <7b5928fe-d93b-4772-a46e-3a9e64f61c14@gmail.com>
Date: Thu, 4 Apr 2024 20:37:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] firmware: qcom: qseecom: convert to using the TZ
 allocator
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Guru Das Srinagesh <quic_gurus@quicinc.com>,
 Andrew Halaney <ahalaney@redhat.com>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@quicinc.com, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240325100359.17001-1-brgl@bgdev.pl>
 <56e1c63a-4c09-4d92-9ef2-aad5390879cc@gmail.com>
 <CAMRc=Mf_pvrh2VMfTVE-ZTypyO010p=to-cd8Q745DzSDXLGFw@mail.gmail.com>
 <CAMRc=MfsVWcoMC-dB-fdxy332h-ucUPTfEUMAnCt5L-q3zJxWg@mail.gmail.com>
 <82f94b54-82d1-49b9-badf-63d948b347fc@gmail.com>
 <97e1f121-9e84-4e63-9c9c-57e2de0b29d7@gmail.com>
 <CAMRc=McLJFGcy-A6PZNmjgDXnvx8z0J4k-Dbak-txvWnycHG2A@mail.gmail.com>
 <2b1dc031-d645-494c-9103-a2bb422ea60b@gmail.com>
 <CAMRc=MdoSPuedbGhy4toDEkw0vSzESDz2bXGpyt_=R4hqXW+Uw@mail.gmail.com>
 <9b1e5ea0-bb32-4c42-b2e9-204bde31b905@gmail.com>
 <CACMJSesvM6_PhhR_2sP4JX6bR4ytVVg=MwWBEVrCHf5FNp2JXw@mail.gmail.com>
 <9db0fc7b-f24a-4d76-b8bd-ec577ecba0c6@gmail.com>
 <CAMRc=Me9x1OXKXXxyhzZ6mxffmaoq=4QhMXCL6L71_xso2epWA@mail.gmail.com>
 <CAMRc=Me0MamtJoPtQnucKyZx9pfkEPDAAZqWFWRU0CBcj+P50A@mail.gmail.com>
 <CAMRc=McZ9dpD7Ws0vq-eYCN3smA6dHOLu_i1BL=x+CAaYr9S2w@mail.gmail.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <CAMRc=McZ9dpD7Ws0vq-eYCN3smA6dHOLu_i1BL=x+CAaYr9S2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/3/24 9:47 AM, Bartosz Golaszewski wrote:
> On Tue, Apr 2, 2024 at 10:44 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> On Sat, Mar 30, 2024 at 8:16 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>
>>> On Fri, 29 Mar 2024 20:57:52 +0100, Maximilian Luz <luzmaximilian@gmail.com> said:
>>>> On 3/29/24 8:46 PM, Bartosz Golaszewski wrote:
>>>>> On Fri, 29 Mar 2024 at 20:39, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>>>>>
>>>>>> On 3/29/24 8:26 PM, Bartosz Golaszewski wrote:
>>>>>>> On Fri, 29 Mar 2024 at 20:22, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>>>>>>>
>>>>>>>> On 3/29/24 8:07 PM, Bartosz Golaszewski wrote:
>>>>>>>>>
>>>>>>>>> Both with and without SHM bridge?
>>>>>>>>
>>>>>>>> With CONFIG_QCOM_TZMEM_MODE_GENERIC=y (and the upcoming fix) everything
>>>>>>>> works. With CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y things unfortunately
>>>>>>>> still get stuck at boot (regardless of the fix). I think that's
>>>>>>>> happening even before anything efivar related should come up.
>>>>>>>>
>>>>>>>
>>>>>>> This is on X13s? I will get one in 3 weeks. Can you get the bootlog
>>>>>>> somehow? Does the laptop have any serial console?
>>>>>>
>>>>>> Surface Pro X (sc8180x), but it should be similar enough to the X13s in
>>>>>> that regard. At least from what people with access to the X13s told me,
>>>>>> the qseecom stuff seems to behave the same.
>>>>>>
>>>>>> Unfortunately I don't have a direct serial console. Best I have is
>>>>>> USB-serial, but it's not even getting there. I'll have to try and see if
>>>>>> I can get some more info on the screen.
>>>>>>
>>>>>
>>>>> I have access to a sc8180x-primus board, does it make sense to test
>>>>> with this one? If so, could you give me instructions on how to do it?
>>>>
>>>> I guess it's worth a shot.
>>>>
>>>>   From what I can tell, there shouldn't be any patches in my tree that
>>>> would conflict with it. So I guess it should just be building it with
>>>> CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y and booting.
>>>>
>>>> I am currently testing it on top of a patched v6.8 tree though (but that
>>>> should just contain patches to get the Pro X running). You can find the
>>>> full tree at
>>>>
>>>>       https://github.com/linux-surface/kernel/tree/spx/v6.8
>>>>
>>>> The last commit is the fix I mentioned, so you might want to revert
>>>> that, since the shmem issue triggers regardless of that and it prevents
>>>> your series from applying cleanly.
>>>>
>>>> Best regards,
>>>> Max
>>>>
>>>
>>> sc8180x-primus' support upstream is quite flaky. The board boots 50% of time.
>>> However it's true that with SHM bridge it gets to:
>>>
>>> mount: mounting efivarfs on /sys/firmware/efi/efivars failed: Operation not supported
>>>
>>> and stops 100% of the time. Without SHM bridge I cannot boot it either because
>>> I suppose I need the patch you sent yesterday. I haven't had the time to
>>> rebase it yet, it's quite intrusive to my series.
>>>
>>> I can confirm that with that patch the board still boots but still 50% of the
>>> time.
>>>
>>> Bart
>>
>> Hi!
>>
>> I was under the impression that until v8, the series worked on sc8180x
>> but I'm seeing that even v7 has the same issue with SHM Bridge on
>> sc8180x-primus. Could you confirm? Because I'm not sure if I should
>> track the differences or the whole thing was broken for this platform
>> from the beginning.
>>
>> Bart
> 
> Interestingly, it doesn't seem like a problem with qseecom - even if I
> disable the driver, the board still freezes after the first SCM call
> using SHM bridge. I suspect - and am trying to clarify that with qcom
> - that this architecture doesn't support SHM bridge but doesn't report
> it either unlike other older platforms. Or maybe there's some quirk
> somewhere. Anyway, I'm on it.

Awesome, thanks!

Best regards,
Max

