Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FD677A64B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 14:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjHMMJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 08:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMMJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 08:09:57 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DC010D0;
        Sun, 13 Aug 2023 05:09:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so5056245e87.3;
        Sun, 13 Aug 2023 05:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691928596; x=1692533396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ka4/Ei76gmsVCMM5bKIvKDlQA9OUfg+fkP/SBEdRDso=;
        b=rhrNSFlZ5A9m8MLQghOzNq+vbRCPTRCVnYJVrIzdB1r7OVBt5HV66ArUTkpPrVpHlP
         VnyxijZagAOHb+2QIqyfMIo4fAKjDyW72BJk1nCqKyLkVllYZlY72BcarIP9Q4CSj9Iu
         RkjK4WtrgRA23Dp3+tn2WezAzW7i6u2UbiavDInn8Shic2xkxJUjC9cSzITkH3AxLzwJ
         aBPULwItLbaHjpf98e5gxUiqgt1+4Fd0FeZW9FL/NTx6u7aa4+h++GFFXkuNiZnYPChX
         31DAbifEBO3EEyLkGRqKjskz3WSFJXEl4K165FmW/MpCeZ0JK2776m55T/z61zFKRxMp
         cdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691928596; x=1692533396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka4/Ei76gmsVCMM5bKIvKDlQA9OUfg+fkP/SBEdRDso=;
        b=Q0/Wu5RF1vItBfpGY+UnNZF35pcV8BEQGn1ZzKQeC6/IFmyI4VyV4fLGClOChPUPlq
         2l0MWHC5v5RztSBO3/n9wgSapYTvI59VNg5p7joPeKJHxo8mIWniheH2kqknktA/IMIv
         1nlMS30L4b8aeFXhDRExrqzDlCqFQLDE7AWeuwEjefiRfNH68eHPeJTvGdrSbuFQKeGK
         YSh1uTP8iXrY+zY3Q10JeQ0oORrXiylZ16VUfy0VAIizKRja0zKm82LKhPcbyXNfzpJN
         uOOqPuq1cqfYgOrODqzcUiOF9W7bFSPvkgekOAK4kUGHkMuMKtq3EHGrcuyx9yR5ksMV
         zYiw==
X-Gm-Message-State: AOJu0YxTZSh++f8DCI9/UmLSo5vdex4+cEympsm6DniMBhlBoCKWMRvs
        yt2N/waPSbg5HaEORvfTvfY=
X-Google-Smtp-Source: AGHT+IG5RLIucS4hxOvSsT7tE3i1mUE/4Tau8c5bMSEYrzAiOrrIowOdha9FTP4FgWGyr3FDF90tLg==
X-Received: by 2002:a05:6512:b84:b0:4f9:dac6:2f41 with SMTP id b4-20020a0565120b8400b004f9dac62f41mr5607938lfv.2.1691928596138;
        Sun, 13 Aug 2023 05:09:56 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:6b00:a1a8:4887:1af4:637a? ([2a00:1370:8180:6b00:a1a8:4887:1af4:637a])
        by smtp.gmail.com with ESMTPSA id w26-20020a19c51a000000b004fb964d48e6sm1520629lfe.95.2023.08.13.05.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 05:09:55 -0700 (PDT)
Message-ID: <d0331f81-0307-db2e-5b78-73afe1f3339b@gmail.com>
Date:   Sun, 13 Aug 2023 15:09:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in af_alg_free_resources
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     syzbot <syzbot+cba21d50095623218389@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000bde775060071a8d7@google.com>
 <9f0365cb-413f-2395-2219-748f77dd95a4@gmail.com>
 <ZNYbArdy+2egdD9m@gondor.apana.org.au>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <ZNYbArdy+2egdD9m@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

Herbert Xu <herbert@gondor.apana.org.au> says:
> On Fri, Jul 14, 2023 at 05:56:54PM +0300, Pavel Skripkin wrote:
>>
>> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> > Reported-by: syzbot+cba21d50095623218389@syzkaller.appspotmail.com
>> 
>> #syz test
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> Will you be submitting this patch?
> 

Yeah, will do it shortly. This bug got lost in my todo list...



With regards,
Pavel Skripkin
