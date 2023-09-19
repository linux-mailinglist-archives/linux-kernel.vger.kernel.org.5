Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ED17A698D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjISRX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISRX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:23:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC78A6;
        Tue, 19 Sep 2023 10:23:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405101a02bcso6148925e9.1;
        Tue, 19 Sep 2023 10:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695144229; x=1695749029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uv9oI1kx1D03B9nZ62QaXDHAZdBJSbt6nu5tpkEgEhM=;
        b=gNT9ULkT0DJ5xYNWnBn6HFNceoZW5pkWBE1azCbtP6xTyqb8HZk7GspiGYK5fbS7Zw
         2I3nEtAU1MstbsOtOt+wTDh1bPHueG4NkWu7sywb9OE1k522McbSaVjLGjUf/cVlX7hc
         64GRtbglbllDDMz1CSLV+2VCuxfeOvf23EuFm4OR+QI6Q6ASDSTk9gbJ6m7QAK9lUVy/
         D0eLSiaomesoS1LnB40uV82J//bw4UFf3UDElGQffyiqE/DybaNTZwNFM4ElM4m7DmYX
         IDuYlvWzxuvbhd+bydPC7axWyExxX36OcUuUjggt2GI3LQrhvDOWgEE9h2eL+i/W1Y0R
         AExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695144229; x=1695749029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uv9oI1kx1D03B9nZ62QaXDHAZdBJSbt6nu5tpkEgEhM=;
        b=DbXU6YrmdIVuG7GLyFE6HowwoOFt8w/4fT1jPGFFgVc7jFlo3xvzSULdGF+nxOTFhb
         xMmKqmFthbs7F24iNxgV6GX70vf+EdTDY2ujSVnPH2YUvxwTSGvc/a42YOfNnrjGTY3n
         CO38pNJPy9Ul6rEccDaqAioaj609NUer6uaUA0gm7FStQWoNmavdTsqFoEnaF+Hv2Jwd
         Qd+Qc7+2eKYJZYCE/BnhMdE/RPaYMYjqxe0uDubJh5/1s/NkCAjCqbZXdvvON5O8UFyh
         6sdEjrUnROW4B6etwE+FLaRWW1CeYB4xmZf9kvLCPQzDvlT4BLNYfHGb8wlU1mLu7GL5
         cSHg==
X-Gm-Message-State: AOJu0Yyex7hMZZUpj3NSza9IZuvL1WDlQ4lpl1embkgQbneSn7Hjv7dP
        Wy2gsvb4DeX59DeqPIJ5aZg=
X-Google-Smtp-Source: AGHT+IFbuYLnQDU+g1YuQ0nUvdT/9Kj7fr+QDbe9EoyulaT930lf1yy5Za03DAYAyZkDFaBPLs0v4A==
X-Received: by 2002:a05:600c:4f12:b0:404:72f9:d59a with SMTP id l18-20020a05600c4f1200b0040472f9d59amr412653wmq.0.1695144228965;
        Tue, 19 Sep 2023 10:23:48 -0700 (PDT)
Received: from [10.0.0.25] ([178.160.241.68])
        by smtp.gmail.com with ESMTPSA id x13-20020a05600c21cd00b00402ff8d6086sm15748972wmj.18.2023.09.19.10.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 10:23:48 -0700 (PDT)
Message-ID: <5e729667-f08b-d358-eff7-65c5d88e4352@gmail.com>
Date:   Tue, 19 Sep 2023 21:23:46 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] ALSA: Add new driver for Marian M2 sound card
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     perex@perex.cz, tiwai@suse.com, corbet@lwn.net,
        alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230918181044.7257-1-ivan.orlov0322@gmail.com>
 <20230918181044.7257-2-ivan.orlov0322@gmail.com>
 <2023091955-dried-popsicle-f3d8@gregkh>
 <56a4a085-6b1d-19c6-4160-4513c8c41e57@gmail.com>
 <2023091917-zippy-alienate-3efc@gregkh>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <2023091917-zippy-alienate-3efc@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/23 12:53, Greg KH wrote:
> On Tue, Sep 19, 2023 at 12:46:34PM +0400, Ivan Orlov wrote:
>> By the way, is there any way to detect such issues automatically? I've seen
>> that the kernel test robot detects a lot of similar stuff, perhaps there is
>> any tools/linters which can be set up locally?
> 
> Not that I know of, sorry, I rely on the kernel test robot for lots of
> these things :)
> 
> But, the robot is running all open tests, so dig into the public repo of
> it to see what it is using and perhaps run those tests locally?  Lots of
> them are just different build options and running sparse.
> 

Alright, I will take a look on the sources. Thank you for the advice! :)

