Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED457DDC22
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345270AbjKAEgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 00:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344341AbjKAEgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:36:52 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C19102
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 21:36:48 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-457c4e4a392so1895887137.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 21:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698813407; x=1699418207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ID+S04pHkx9aSKdp+ucIhh2PVs3MifW7Ts+8UbZjHPQ=;
        b=SNivXMfD1r2UTkiVgFup6bvLT4FDiCVNeHZzBncHYLwxQ+nUWWnKk67ysW0pKA5PDd
         W+uQ9GAsFJ9KMJPRF9oukF/ymb9GbxjHwWzBuuzNG0p5T9ez7sOwlih7OR1BJsslSAT4
         1uG9ZuZbKMQGgiB9W5kZFctdYgcXSprni/YKNy7w20lABGwEVWMkwzSFtdUkcMcuT26P
         h1JQs5Ypr+gbDzmubh8ei4Y0xbbhd/UQgUTFcZaFAMGmglSS5GqCF20cZYBnz9mG/48G
         9fDsQu/Y2BEE5/PApQ09YHyw8ay8tYiQ/J4R37e09mKGsYCq0NSSPRl+zG4DGoBUOnyU
         QSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698813407; x=1699418207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ID+S04pHkx9aSKdp+ucIhh2PVs3MifW7Ts+8UbZjHPQ=;
        b=tYl4wtwXepnn7FoYg74M7163VASbmbMMN9f0pP+cXh689vV7fobNmslODXphC+Kq1h
         WhpLJhXJljtCCTHxuOxQzhBukWKf8FiQbJ0AgBZGDZ9Eb3N/eH5W5CPavrNyvjDkqCUq
         diHE5/7kkqKiHCGcKE+NSV2aBRgnbmG3UO+Lq5Fw+sW9XByKNtpV9r7eSaPEABDtZzsf
         7jz/rlMvc7kdnAhqGxxUSCOeM6bqgn5HhEuWnA2uQQ52zHMfdWmX6djO4PFEBR0loj/l
         NpOTgoQnc6sR09ihBgarR/j98/YJVPsgKqi3wsy0++T9yDo4M8Hnnkz8kxpHuGNM7gM1
         AHBw==
X-Gm-Message-State: AOJu0YxpnF7rwwH0FO7hO7u5bqeE4EKF/L+K4vwIrGieJHeoef6n3Dbi
        pqrqKbMALcNzFCWAKyK0znVnhjVJljTAp9a86OG+Ak5phyIHSiZkGzW5Zw==
X-Google-Smtp-Source: AGHT+IGGPNy92jDHvzo6JCYso3G1dtSpwuYY7OA/tZfjM1GsDrY498EUJvuQNbMJaRXlcFCh5cGPYqjJsOt5s/jDg6k=
X-Received: by 2002:a67:e0d8:0:b0:45b:ede:fbcf with SMTP id
 m24-20020a67e0d8000000b0045b0edefbcfmr9395038vsl.8.1698813407287; Tue, 31 Oct
 2023 21:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231031044021.1162403-1-mnkumar@google.com> <20231031044021.1162403-3-mnkumar@google.com>
 <CA+Hc5+4Gh6gDuD_NORmJR0zHx3qK6oTagx=wQ_EWf=_NJ0qy6A@mail.gmail.com>
In-Reply-To: <CA+Hc5+4Gh6gDuD_NORmJR0zHx3qK6oTagx=wQ_EWf=_NJ0qy6A@mail.gmail.com>
From:   Naveen Kumar M <mnkumar@google.com>
Date:   Wed, 1 Nov 2023 10:06:36 +0530
Message-ID: <CA+Hc5+72DurrRMNtMyzg9EDwJjDJx4iR1isU=L+6DG06Gx4iMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: usb: add no-64-bit-support property
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        royluo@google.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for sending without plain text mode in the previous mail.
Adding the reviewers/maintainers I missed in the initial mail to this
patch

On Wed, Nov 1, 2023 at 9:50=E2=80=AFAM Naveen Kumar M <mnkumar@google.com> =
wrote:
>
> Adding the reviewers/maintainers I missed in the previous mail to this pa=
tch
>
> On Tue, Oct 31, 2023 at 10:11=E2=80=AFAM Naveen Kumar <mnkumar@google.com=
> wrote:
>>
>> From: Naveen Kumar M <mnkumar@google.com>
>>
>> Add a new DT option to specify whether a host controller is able to
>> support 64-bit DMA memory pointers
>>
>> Signed-off-by: Naveen Kumar M <mnkumar@google.com>
>> ---
>>  Documentation/devicetree/bindings/usb/usb-xhci.yaml | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.yaml b/Docum=
entation/devicetree/bindings/usb/usb-xhci.yaml
>> index 180a261c3e8f..20dc134004f3 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-xhci.yaml
>> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
>> @@ -25,6 +25,10 @@ properties:
>>      description: Set if the controller has broken port disable mechanis=
m
>>      type: boolean
>>
>> +  quirk-no-64-bit-support:
>> +    description: Set if the xHC doesn't support 64-bit DMA memory point=
ers
>> +    type: boolean
>> +
>>    imod-interval-ns:
>>      description: Interrupt moderation interval
>>      default: 5000
>> --
>> 2.42.0.820.g83a721a137-goog
>>
