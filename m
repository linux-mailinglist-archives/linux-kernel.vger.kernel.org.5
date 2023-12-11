Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCB980DFB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345396AbjLKXt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345397AbjLKXtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:49:24 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA0BD9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 15:49:30 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7b37a2e6314so45226339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 15:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702338569; x=1702943369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g5t6eoQm4Z4Er6PwnibCjr1u9wVQuH1O71YB60iqa3I=;
        b=DeBSqQKz0yrvNHY0gG8MorHJqfz674i0hU6DYYh6DBF2zDGTYsc5tCK2sfm5L5RRxI
         RSdnbJKvllOJcdlNT8jM1nxT3wKyOjQWM/2EsyJ2Pmx7c37d0StwTfLV+268nw+U6GMH
         zLZtgMmS95l8QHeHHEp7HLvwDlm3xeGkPAcFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702338569; x=1702943369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5t6eoQm4Z4Er6PwnibCjr1u9wVQuH1O71YB60iqa3I=;
        b=t2dlJQSmIR2jPKmCkzEi1dJadgdEpayy+JMvJfuCp6lvk0Y1zTvcuE7XazXk8mjvL3
         9mOJPdAvYteOYWXZ3aROSByZyzzw9OF75XHvxCt5MbBxI2nqOq/Aa1tFEx5kT5cy8r6L
         18B1SHWYw3JIrO4RRlClyL3rlmco3UqpOn3zdlNXwHN9h/JyJ4JjXJohnnX4YaslFKVw
         wk9sPKh2+7iX8lYeHjWnjgkR/cGP2QLSC0RX6GNrmGdOlYSD2RvAQ5yl7rb3Olis30K+
         H/0EvMLOQ0TK1KsFAJKHE+nz+kizD5SBItdsqxCRiM2yLYivS/JVA1mq0iVYiM2a+749
         CV4w==
X-Gm-Message-State: AOJu0YyYmoVp5ySajhzdHRRFgGRqsu0Owx04VtDzwo/Lxi2fLT5cQAWs
        pDqZDngoIlksXd+ej+7zM1Vg7A==
X-Google-Smtp-Source: AGHT+IET8RjedN/i/RllToFd1KnVFkwCbr2HjFQomHV8tjSUOqJzpytEkyxj1r3j8oUPosbYIRS32g==
X-Received: by 2002:a05:6e02:2189:b0:35d:81ce:fd91 with SMTP id j9-20020a056e02218900b0035d81cefd91mr9319707ila.0.1702338569614;
        Mon, 11 Dec 2023 15:49:29 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id k3-20020a02c643000000b004666cb039bfsm2102313jan.160.2023.12.11.15.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 15:49:29 -0800 (PST)
Message-ID: <ef2d9d5f-e485-465c-98b7-d993610ae10e@linuxfoundation.org>
Date:   Mon, 11 Dec 2023 16:49:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nolibc changes for 6.8
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, WillyTarreauw@lwt.eu,
        Shuah Khan <skhan@linuxfoundation.org>
References: <4208adae-d185-44a6-a564-ec9bc4c6eb2a@t-8ch.de>
 <4074b0bc-e89b-4b2e-ad11-cb3a9517b725@linuxfoundation.org>
 <d486df54-4484-4f6a-b40f-aebeb5f0131a@t-8ch.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <d486df54-4484-4f6a-b40f-aebeb5f0131a@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 12/11/23 14:40, Thomas Weißschuh wrote:
> Hi Shuah,
> 

> 
> Thanks for spotting this!
> 
> The fixed commits are published on the same "next" branch as before with
> final commit d543d9ddf593b1f4cb1d57d9ac0ad279fe18adaf.
> 

Thank you.

Pulled and pushed to linux-kselftest nolibc branch.

thanks,
-- Shuah

