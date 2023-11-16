Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BFC7EE86A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjKPUjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKPUjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:39:35 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D21B98
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:39:31 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9cbba16084so1214088276.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700167170; x=1700771970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ie4bIp+/8X3baaFx5LodBCI7zgnvFrvMzLlKJ9qcML4=;
        b=mTZBx4IkQ79AMp8rx/4siUqlA3amnJIxLXVvYGCGBhm4C+dzYByVlDRUJnPVfQuTyu
         Q39eqSd6au/Shk+YfRyFtwf4a4MRz0DzpHVncTHSpA3pSSqC5OzUNiSennMgYET9/biq
         gu4Nr0oHsyWUXu7adNoyRrYu3/0w8vO0p+Qquq6ao4/2M74SS0kZ2pIyeE2N7qTW8KLF
         Zka1PQpGGTl7B1XaP8vD1qrY0DoqMOFoHxLYzXk80aVQ4UHkiW7Nv6FAcLZD9RCmXJW/
         Zej9UZsiS0new5umN3cu46MERDXOrcGuhUJOU+rFn7LWCZowI2ihl89nzbCRhKLFpTur
         1QXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700167170; x=1700771970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ie4bIp+/8X3baaFx5LodBCI7zgnvFrvMzLlKJ9qcML4=;
        b=fj+ctT90I5ZnRyMBCZOi/+MT4W1IjOiNAp+xKU4J6rFruuD8MIvVBhD9Pbz6gwUpRf
         TXVGKH7yIQ1GJoJhrPx56QlYUxxKFN6w5aukos6qriXXHy6CElUmjCFb2aUOxYFE/CjS
         wylSZ+qUObif04r6F8xIjmXkNV7spgbt5x1jVK8eHGv3FcZsKA+IDkcMEjBWPFYlutNy
         KMzDh8GVx1853bscvaxdm66JwvLW5fEOsZpXmBEEniUK7JlzzN86+2UwiH/O0whhlfME
         4cRPIfMfXS038YJPXOWBDbkAJajysri/sspSMh9ks67ISUzlemo8tLtfQUaIs9LZYniG
         uW+g==
X-Gm-Message-State: AOJu0YzzZDC/lZDYIJjaUxvPLm0QGNhG4aKmlPOGpOnUNox4alm/DV27
        V3ygWcvBelbvLS4M0ibhnokD4jO3bBZEX4SY1baXkw==
X-Google-Smtp-Source: AGHT+IEl05nrGsWTPLgWubxHE+fCn4FbX2jQkSHiv84o+RQr7HDu/P2diCHWO/l3K96sMozK9YE7r3a4UuHHpB6baak=
X-Received: by 2002:a25:400f:0:b0:da0:c49a:5fed with SMTP id
 n15-20020a25400f000000b00da0c49a5fedmr13754181yba.50.1700167170644; Thu, 16
 Nov 2023 12:39:30 -0800 (PST)
MIME-Version: 1.0
References: <20231113221528.749481-1-dmitry.baryshkov@linaro.org> <20231116183609.GA2742530-robh@kernel.org>
In-Reply-To: <20231116183609.GA2742530-robh@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Nov 2023 22:39:19 +0200
Message-ID: <CAA8EJppW3v7Ozr+KnoYYF6GXE5DqqMjEiETpaqfC_sE3ufNhfA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] dt-bindings: connector: usb: provide bindings for altmodes
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 at 20:36, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Nov 14, 2023 at 12:13:26AM +0200, Dmitry Baryshkov wrote:
> > In some cases we need a way to specify USB-C AltModes that can be
> > supportd on the particular USB-C connector. For example, x86 INT33FE
> > driver does this by populating fwnode properties internally. For the
> > Qualcomm Robotics RB5 platform (and several similar devices which use
> > Qualcomm PMIC TCPM) we have to put this information to the DT.
> >
> > Provide the DT bindings for this kind of information and while we are at
> > it, change svid property to be 16-bit unsigned integer instead of a
> > simple u32.
> >
> > NOTE: usage of u16 is not compatible with the recenty extended
> > qcom/qrb5165-rb5.dts DT file. I'm looking for the guidance from DT and
> > USB maintainers whether to retain u32 usage or it's better to switch to
> > u16.
>
> Depends if you are fine with the ABI break on this platform...

As much as I hate it, yes, we are.

-- 
With best wishes
Dmitry
