Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10094773D13
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjHHQN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjHHQMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:12:18 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9747ABB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:46:59 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a7a180c3faso1326131b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691509617; x=1692114417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5gVaSTYejp99j2UgPSGmR/5wX1Q1ia2oLZnesCpWyfk=;
        b=HGWFRVZU2sTmmA4UmKsh+aABrf/QwQbBRXJZEYiFo+65XnWZMvdGQwbGweYO0H2VXd
         m3FgcA8yKDvkcY2GASxBYZAoJMeEn6iQWVN/xK3Ivglk1joBf1utgDsH/ckMPyCtHCNW
         +QXeUEJRkcBvHz9Q1BomddbE1dx7CfttdlAutOVIBO0htkYL5+1DwG83/yagbd0GR4EK
         cauybPVXWlzrbexFR/sjFBN2jTld/U0wHfefuSYIZt+HoeshW8HD5t61cBswo0av4I09
         BToLzeVNmFD96v6bLSARrH4AFg4iRsWDETiW75PpoqaAQWfQy1Az1f4PpWYJb9YKYWp3
         OdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509617; x=1692114417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gVaSTYejp99j2UgPSGmR/5wX1Q1ia2oLZnesCpWyfk=;
        b=MsJW8mhIfS15q4gbvIPWLspMSwb4CynmA/ICaryQmOoQ7HYd9+GVcwTZOQ3ZcfbEG4
         Dnvhqc0S9lgwT9VcghMcBeMyGWKnc1ulbT0ABZ3umY5nDU+n1agrSY+wLC/0GzBHmhbw
         CKkBIBX0kqLzFQBOYpJWFCzXxlIO7j8bt3hioPnFMK0ne5o0+QlCtj+ID5j0XlBs0EPD
         FjNQZgWkUao4L0mhCoDiWn3kYsnuyVV2xAeGRbaysT67OEuwlUcPQJJng27zUVwEyCR4
         W9G6E+lhWBMq/V4b3dCcMAC26A6QCMj8GvJ4Z758rBCEP+72D5wk5Hb7ZuAekIXkHgQ2
         aJ7w==
X-Gm-Message-State: AOJu0YwZw5BpPeVTvTSjr9jtvrWdJ3JuVR1y/ojlC1fkU2+wiYcyUzCH
        ob3jnsXFc4wLTRLbAeGTv/jItepjSog=
X-Google-Smtp-Source: AGHT+IFBIakaNZTIdA4oBI0rRadsOxlGCM7E8XCGcQIJSD++iUF3+awZ266RBP1ugSs47Y8uw2N+pA==
X-Received: by 2002:a05:6a00:194a:b0:687:596e:fa6a with SMTP id s10-20020a056a00194a00b00687596efa6amr14097463pfk.16.1691480967688;
        Tue, 08 Aug 2023 00:49:27 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id e19-20020a62aa13000000b006875df4773fsm7404855pff.163.2023.08.08.00.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 00:49:27 -0700 (PDT)
Message-ID: <103c4acd-df75-4d5f-9f53-ce956c01aca5@gmail.com>
Date:   Tue, 8 Aug 2023 16:49:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: amd: acp3x-rt5682-max9836: Configure jack as not
 detecting Line Out
Content-Language: en-US
To:     Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
References: <20230805162216.441410-1-alpernebiyasak@gmail.com>
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230805162216.441410-1-alpernebiyasak@gmail.com>
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

On 2023/08/06 1:22, Alper Nebi Yasak wrote:
> The RT5682, RT1015 and RT1015p codecs used in this driver do not seem
> capable of distinguishing Line Out connections from Headphone, but
> the driver configures its jack object as if it can. Remove the wrong
> value from the jack creation call to avoid any confusion.
> 
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
