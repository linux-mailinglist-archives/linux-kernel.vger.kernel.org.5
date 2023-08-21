Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72653782A12
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbjHUNMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjHUNMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:12:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54753E3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692623502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8jlzIYKgKmR2UBRoCBcFv7SS0ZLgGsr3htxCffkKfOg=;
        b=ev8pSrPaTv2QnhIV/i4HmSlh62cVgwhI1yeRsPBSDn8PG3sSz75BwebuTOvn0/Bcgimc02
        ZCeIqGguMgjDd0ePP7WhDTsFgqlv3Ai6XCiqblNvc3x3IDyFRnduIvTmNAVUIl1kAjSdjn
        OBMOL414xylCKM0VPiphUqAwpt0+vKk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-y_Ir6XThPT6E5-0m7WcrMA-1; Mon, 21 Aug 2023 09:11:41 -0400
X-MC-Unique: y_Ir6XThPT6E5-0m7WcrMA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-58cbf62bae8so47273107b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692623500; x=1693228300;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jlzIYKgKmR2UBRoCBcFv7SS0ZLgGsr3htxCffkKfOg=;
        b=e0kVEjTEcTyUAR6xccr5TvtRzZ1ZW1C3+vf0S++FJHqX7jqCJR4zY4LiWEopvii5eS
         fCftuHMJNtkO269XF255LWsqQ8RkxemHAZqbsQvZvirjX85ACjUb8o71Am+2YOP/hzcd
         b6ooliNxba5EyMSF5CPTRord6lpSrtaqQLdiXGxBH8DEYpq7dgltIA8TALA4S0BWqnqf
         tQSXyzJUV2E12nO79DQc0Yqb4D67Troz5+UnBt9/ERhG646BOfUf2OR1pK6tnVyIRTsO
         fM7np4kyB7Eekje6DaI8PzkH8XcBhJxYJJ9V8koUEOUbKYfMvbyV089cEfp9aKM0LNym
         WtLQ==
X-Gm-Message-State: AOJu0YwbIuMZOTYh/wUmpvFsIPabEYOxBhcW8C271dvZaWv8Rb9WA3aO
        GZRuTRKGugYPAZsVzAq9xBG6dQivOeTp29IUj7+K2UGGrA4rXVk8Hbk3LPCN4F7dP8xJlal0Pjb
        /l9vCW+PGS4hnCqpiSOc+nNWM
X-Received: by 2002:a0d:dfd1:0:b0:57a:897e:abce with SMTP id i200-20020a0ddfd1000000b0057a897eabcemr9208171ywe.7.1692623500702;
        Mon, 21 Aug 2023 06:11:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYvkFaI4yVV4NClUb0bxAuCbQrwyZPApNnu6TfahyfIVJgPfoUnef2NcETLjYTx5bvN/PN+A==
X-Received: by 2002:a0d:dfd1:0:b0:57a:897e:abce with SMTP id i200-20020a0ddfd1000000b0057a897eabcemr9208148ywe.7.1692623500477;
        Mon, 21 Aug 2023 06:11:40 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id z1-20020a818901000000b005869d9535dcsm2231861ywf.55.2023.08.21.06.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 06:11:39 -0700 (PDT)
Date:   Mon, 21 Aug 2023 09:11:37 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>, andersson@kernel.org,
        linus.walleij@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom-pmic-gpio: silence -EPROBE_DEFER message
 on probe
Message-ID: <ZONiidFpXf7MR6y9@brian-x1>
References: <20230817145941.1091418-1-bmasney@redhat.com>
 <a3431eaf-053a-4e1c-b082-e87a3aaefbf3@linaro.org>
 <ZN5KIlI+RDu92jsi@brian-x1>
 <09df85cd-27c7-d64c-9792-41110bf32fce@kernel.org>
 <1dd0bad4-fbb4-3861-9bc0-7a5f3067aeaf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dd0bad4-fbb4-3861-9bc0-7a5f3067aeaf@kernel.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 03:59:18PM +0200, Krzysztof Kozlowski wrote:
> On 18/08/2023 15:51, Krzysztof Kozlowski wrote:
> >>     qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: no hogs found
> >>     qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: error -EPROBE_DEFER: can't add gpio chip
> >>     qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: Driver qcom-spmi-gpio requests probe deferral
> >>     platform c440000.spmi:pmic@2:gpio@8800: Added to deferred list
> >>
> >> The second time it probes the device is successfully added.
> > 
> > There is a bug in DTS. I'll send a patch.
> 
> https://lore.kernel.org/linux-arm-msm/20230818135538.47481-1-krzysztof.kozlowski@linaro.org/T/#u

Thanks for sending that. I didn't look at the DTS. Let's just drop the
patch that I posted here since that message may help someone in the
future identify this same type of issue for another platform.

Brian

