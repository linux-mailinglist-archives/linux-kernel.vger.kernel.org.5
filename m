Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC71F78CF52
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbjH2WBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbjH2WAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:00:54 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF59185;
        Tue, 29 Aug 2023 15:00:51 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-564b8e60ce9so2492941a12.2;
        Tue, 29 Aug 2023 15:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693346451; x=1693951251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7AbmmeaYNSK+xFuTeyE4JSZ3qAAot8leOcqkK7mLOP4=;
        b=Lf9lkMguOJXNlNXHeJY7P6X50Kbce+DmFwWwM0IcGsOKE4sKhi3S/eWi/DIJGuk4Gi
         sBi2Fa80CtSEVaAEFIcfiC+oL46MijY8bUysJuwCtbtlRGKYuApTt+IIQiA2XjKLdIm7
         BMsP5j2LEt6ALe4TE8Z+U6+PfTgq5mxfC9ygh0ADfhpJ57RViU7Dt6Sd/b59Vkz8XUvV
         XTbIDUqY0WAdXVftQbVmXObrg6el5IFZgu49V0GbxhoViITw5UigVrbrI91WA8yXKMn0
         9XoUf/Op+ulNCnTJtHZfbF/PvI4IMacWjAjr12GLqTRoQzVOOu3FztxQKvVL8RMUxhW0
         Wdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693346451; x=1693951251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AbmmeaYNSK+xFuTeyE4JSZ3qAAot8leOcqkK7mLOP4=;
        b=lCWF7QoeNkdtdU7xRO/olQPF14ymlAu8vaWXaVotasxYu6K67riXXQhYbfcEf1D6hX
         WGVxrT69pRNI6APOAFUcJQF5X8I4jZg766d5hKj1om1PCiIJrUw6dW8VdoQbMGJohNGQ
         jARCxxA0hd45uSBnW1hU+gTZKoyuRnZhVnbNGdpjf0J9yqHFNMuIYMW0ECvyJ4xRfdOE
         but7+Bg+wdGooz+13eL/1G64e9lN+EnKY4LfJnK7aBNW+vVf0yEPH+2PNr32I6Hk9uAf
         95DMLeDBQDGVglXhC0HuXfrESskFFeSpPvzDb87ShoaKsWDT2biG8W8yI6fgYJDZn0oF
         cJCg==
X-Gm-Message-State: AOJu0Yz54ZHyCfjICOz9QBQCukuur7OxgIwjFrYI/sKtQrAJqtBwEYU7
        tM1VO+EsBCci8rQehKKZYk0=
X-Google-Smtp-Source: AGHT+IH8QCwNZ3CYO9kZlCcZAA/jbZZ6Rff9v9fSRJEhU61IgCz0RBRhELjO4xJmijLtwY4RPBmAyA==
X-Received: by 2002:a05:6a20:970a:b0:137:7198:af9b with SMTP id hr10-20020a056a20970a00b001377198af9bmr452096pzc.56.1693346451066;
        Tue, 29 Aug 2023 15:00:51 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t16-20020a639550000000b0056f8b44058csm9344965pgn.12.2023.08.29.15.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 15:00:50 -0700 (PDT)
Message-ID: <8ea50868-8854-1b4a-b43d-253279fabdd4@gmail.com>
Date:   Tue, 29 Aug 2023 15:00:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Content-Language: en-US
To:     Tristram.Ha@microchip.com, olteanv@gmail.com
Cc:     andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, Woojung.Huh@microchip.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, lukma@denx.de
References: <20230824154827.166274-1-lukma@denx.de>
 <20230824154827.166274-2-lukma@denx.de>
 <BYAPR11MB35583A648E4E44944A0172A0ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230825103911.682b3d70@wsk>
 <862e5225-2d8e-8b8f-fc6d-c9b48ac74bfc@gmail.com>
 <BYAPR11MB3558A24A05D30BA93408851EECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230826104910.voaw3ndvs52yoy2v@skbuf>
 <BYAPR11MB3558EFBB4DBC86AC3C338747ECE7A@BYAPR11MB3558.namprd11.prod.outlook.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <BYAPR11MB3558EFBB4DBC86AC3C338747ECE7A@BYAPR11MB3558.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 14:57, Tristram.Ha@microchip.com wrote:
>> On Fri, Aug 25, 2023 at 06:48:41PM +0000, Tristram.Ha@microchip.com wrote:
>>>>> IMHO adding functions to MMD modification would facilitate further
>>>>> development (for example LED setup).
>>>>
>>>> We already have some KSZ9477 specific initialization done in the Micrel
>>>> PHY driver under drivers/net/phy/micrel.c, can we converge on the PHY
>>>> driver which has a reasonable amount of infrastructure for dealing with
>>>> workarounds, indirect or direct MMD accesses etc.?
>>>
>>> Actually the internal PHY used in the KSZ9897/KSZ9477/KSZ9893 switches
>>> are special and only used inside those switches.  Putting all the switch
>>> related code in Micrel PHY driver does not really help.  When the switch
>>> is reset all those PHY registers need to be set again, but the PHY driver
>>> only executes those code during PHY initialization.  I do not know if
>>> there is a good way to tell the PHY to re-initialize again.
>>
>> Suppose there was a method to tell the PHY driver to re-initialize itself.
>> What would be the key points in which the DSA switch driver would need
>> to trigger that method? Where is the switch reset at runtime?
> 
> Currently the DSA switch driver loads independently and is then
> controlled by the main DSA driver.  The switch is reset during
> initialization, and later the PHYs are initialized.  I was talking
> hypothetically that the switch may need to be reset to correct some
> hardware problems, but then there may be no good way to tell the PHYs to
> re-initialize.

There is phy_init_hw() which will do just that.
-- 
Florian

