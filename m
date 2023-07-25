Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B125F760D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjGYIlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjGYIk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:40:59 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CCE2D44;
        Tue, 25 Jul 2023 01:40:28 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbfa811667so39206065e9.1;
        Tue, 25 Jul 2023 01:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690274426; x=1690879226;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgtRdgA8tKSxtLzk81jR6TOCvg7DqWeabeNFPWwPwTQ=;
        b=kHqbAzKeFsXBFmddI5JrFf6cmXRylrbxpkJKjlFeRX2k/vJnQkDi1aDHDQcE03dFxd
         3c7NxlsHyr8Yo13TffpwIrjMEWKHhAQEDMed4CqPDCCDzwIzScxxF/Xl7OMJj9AjoA2/
         m28jn4b+bIlXkZKDKwqxWmi3AWzifMjaYi7ard6csrhnvzJmBVyxoukNDWEyoGNKt5f2
         /scHlSNvpVAQcAeeT3YbNTTDJTr758BiK0HYH3vbzTO0x79PwkmmcS3fgw9GI9oMOYDy
         dNMfxxe9y+Hc3O5olybqU6X2eW7Rtjp4RMfW8gfY33VtfSUhozfn1zIW3ONv9uydIGiV
         jdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274426; x=1690879226;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GgtRdgA8tKSxtLzk81jR6TOCvg7DqWeabeNFPWwPwTQ=;
        b=bg58sSNJ45rxqLBV9EAiosZfZCv1MJs7kwLZCTYcaEDYHBWJGDDQlKlpWz1XjvhLOx
         pHsy0S8j1zxphSzOD8Mp3AvkFFVtH9D/F1N/F7yTqm0RkFt1HNfQvRVcw2Zeaw6o8Z1O
         cL8g/dLQA8RB1Dz7T1CPN6otokyet4SuMnNxK92m30IS4NVPnXb3suwrEiM6gJE5IZvp
         nmMKt+SmwXaMudrZFe9S6a+rpoUP0Lp/7sM01tDA2s8gRPhRCFv8TnC8Ed3EuEpg77RT
         lUA46KIdoD5MOD8/txV0xcdWadHQV4CFQ0xYRmd1Ry1RwO5kC9fXJuU/hepl3sYoEfPf
         xGTQ==
X-Gm-Message-State: ABy/qLaH5Egb2vDJB6Qsi0Q/7kYjVt6MEWLZyAEqFQRap52JQSTxXuyh
        QJ+mKr+2CM3p+A0K8bOagTEwMLnfMuY=
X-Google-Smtp-Source: APBJJlFPVvpDnmoUJfnPTabvgR2Qj3KB7XfS4GXE8gxPk3vKzl4GIedRmTQUbHdtXUzbbdzFRzkcUQ==
X-Received: by 2002:a05:600c:22c3:b0:3f4:2a69:409 with SMTP id 3-20020a05600c22c300b003f42a690409mr1382426wmg.11.1690274426344;
        Tue, 25 Jul 2023 01:40:26 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id w3-20020a05600c014300b003fc05b89e5bsm12308549wmm.34.2023.07.25.01.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 01:40:25 -0700 (PDT)
Subject: Re: [net 0/2] rxfh with custom RSS fixes
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
        saeedm@nvidia.com, tariqt@nvidia.com, ecree@solarflare.com,
        andrew@lunn.ch, davem@davemloft.net, leon@kernel.org,
        pabeni@redhat.com, bhutchings@solarflare.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
References: <20230723150658.241597-1-jdamato@fastly.com>
 <b52f55ef-f166-cd1a-85b5-5fe32fe5f525@gmail.com>
 <20230724150815.494ae294@kernel.org>
From:   Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <f565a8d6-e3b8-96d1-a7ac-212c64c60b1c@gmail.com>
Date:   Tue, 25 Jul 2023 09:40:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230724150815.494ae294@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 23:08, Jakub Kicinski wrote:
> What's the status on your work? Are you planning to split the RSS
> config from ethtool or am I reading too much into what you said?

I was just thinking that when netlink dumps get added it would make
 sense to also extend the netlink version of SRSSH (which is what
 calls the rxfh_context ethtool_ops, via the misleadingly named
 ethtool_set_rxfh()) to include the hash fields setting that's
 currently done through ETHTOOL_SRXFH.  In which case I should add
 that data to struct ethtool_rxfh_context, and include it in the
 get/create/modify_rss_context ethtool_ops API.
Since it only occurred to me to consider that setting when I saw
 Joe's patches, I haven't really figured out yet how to go about
 the implementation of that.

More generally the status of my RSS work is that I've been umming
 and ahhing about that mutex you didn't like (I still think it's
 the Right Thing) so I've not made much progress with it.
And I should place on record that probably once I've gotten the
 kernel-driver API done I'll leave the netlink/uAPI stuff for
 someone else to do as I really don't have the relevant expertise.

> It'd be great to push the uAPI extensions back and make them
> netlink-only, but we can't make Joe wait if it takes a long time
> to finish up the basic conversion :(

Yeah as I said upthread I don't think we should make Joe wait, if
 he's got a use case that actually needs it (have you, Joe?  Or
 is it only GRXFH you need and the investigation just led you to
 notice SRXFH was broken?)

-ed
