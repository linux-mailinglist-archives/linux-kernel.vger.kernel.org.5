Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB7A7EE6D3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjKPSgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjKPSgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:36:14 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845A71AD;
        Thu, 16 Nov 2023 10:36:11 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6d67d32adc2so612144a34.2;
        Thu, 16 Nov 2023 10:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700159771; x=1700764571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l664GmxrgPjuwcC4+iWO5BImv8+Ysd5uofTp+SZ3EtQ=;
        b=MyqnP+WFd8bC4oq0i7/MLYSHXjQnxhYN2cT5GG1slmtmHvcgDTwfo8WKZ0n26fbGRI
         kJAfBKlAx1/Qf6KCjQeVXfUvqkD4sOrV1ddvxoNcKbczxAAcaxivEk/Br+okOsQWwYAR
         oYidDwMev/fRIOR7docR67QNquwwjt3GPhtMGR9RKUw+rgv5YndPlnwsz4RvZNoZvqZ0
         JQG7YMGRsow8hpbQOI5FJgo9E+fkoF98SAuRdrcxiwQqwx9lEJ5DMhF532kAmS6oa4xq
         COfccpBd+O7awkTgWSChmQxHJGnp8Abl69juPSt9pBer+uHuhxh7fhkxc+EuPboznWid
         JAog==
X-Gm-Message-State: AOJu0YwpUhsGoTQ4ffXxIxrLh6yQwq8V9ptQr4eTfOoOKM9zPxPT4xKM
        sB/QzktWiMjEi3keXV7sfg==
X-Google-Smtp-Source: AGHT+IECY03TsLRs0oGlkUq/iwK4eJMeWbz6d/rZUHpXcAxKlWApqjsSErN0XjgUFVsSkueEAMlNaA==
X-Received: by 2002:a05:6830:1bdc:b0:6d6:3926:9a2b with SMTP id v28-20020a0568301bdc00b006d639269a2bmr9644653ota.26.1700159770825;
        Thu, 16 Nov 2023 10:36:10 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q16-20020a05683033d000b006ce2e6eb5bfsm1005504ott.0.2023.11.16.10.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:36:10 -0800 (PST)
Received: (nullmailer pid 2814974 invoked by uid 1000);
        Thu, 16 Nov 2023 18:36:09 -0000
Date:   Thu, 16 Nov 2023 12:36:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 0/3] dt-bindings: connector: usb: provide bindings for
 altmodes
Message-ID: <20231116183609.GA2742530-robh@kernel.org>
References: <20231113221528.749481-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113221528.749481-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 12:13:26AM +0200, Dmitry Baryshkov wrote:
> In some cases we need a way to specify USB-C AltModes that can be
> supportd on the particular USB-C connector. For example, x86 INT33FE
> driver does this by populating fwnode properties internally. For the
> Qualcomm Robotics RB5 platform (and several similar devices which use
> Qualcomm PMIC TCPM) we have to put this information to the DT.
> 
> Provide the DT bindings for this kind of information and while we are at
> it, change svid property to be 16-bit unsigned integer instead of a
> simple u32.
> 
> NOTE: usage of u16 is not compatible with the recenty extended
> qcom/qrb5165-rb5.dts DT file. I'm looking for the guidance from DT and
> USB maintainers whether to retain u32 usage or it's better to switch to
> u16.

Depends if you are fine with the ABI break on this platform...

Rob
