Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D35977EF96
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 05:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347868AbjHQDf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 23:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347857AbjHQDfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 23:35:23 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B83D2110;
        Wed, 16 Aug 2023 20:35:21 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-688779ffcfdso1620882b3a.1;
        Wed, 16 Aug 2023 20:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692243321; x=1692848121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hBdpvPB6uEEiKinZQMEcCksuN2D5HSupo0xUfRm4FcY=;
        b=AlZiXkWiw+M/HsFs9sJhfJbZdJwRhnd3KcWgFj6Q7AT9n/CIf2cSW0cimST1Eq2m+L
         wsBBao3b//PSdL21lbs8nV/hXu+OdQBmyXDRIaF/lkYKMT285iU3dfFgZtgCOXcqCbkN
         ot+AHVXdf87eOHj1oP7eUOUI8w+V5ZTfkcDXemiZDPqqpBP/+o9JXX+VDvAldHc3tzWv
         GwE+TJxW7qC6MqpdJ4p2U8JpH3X2B/eXmA8Yya8pRK07t0K+AijpnjI3bHY2DxvtI1uJ
         pTonduoRn7djY5QKfbJAqctzolm8Z5RVDlnp66flT0xNuSZ/1uEFY0ppYMkbhb5eq8kK
         HIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692243321; x=1692848121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBdpvPB6uEEiKinZQMEcCksuN2D5HSupo0xUfRm4FcY=;
        b=OCqP/lvx/k1VrERWGe3PAxzsawac69yllgwXVbaDyVqqVwRBm8MWOjmgJMcGaTspOH
         xMhkbZQKgdYbtvwjg2A5LdGUAnYKnFLwkPoEu/oFDQ73CskV/z5BWaGVKc8hS1mucU6/
         X+N3UXmvVurPbhD2t2UPZ73Kq4/j+cIC72oB/7rGpkn/l7C3XVru290cGLeIT2RUfBnI
         M/LMXJwHEgAW2X4KVQl6WeIeBYsBzMZfYRYBK4+jrtd/oduG4+CAL4Yk0SN/n/IOmWMp
         gkvSBo+oCZiddbuarm9OqZggJk8Cf1COXSEG12mAnMw3HEDXzQIknClOLcZbq4C0wCbO
         VblA==
X-Gm-Message-State: AOJu0YwkueS0bip3mwXAuERnXSdO0MR5F96Ucmmf7n/gEEgbpPBsRnEI
        0JOa1XZevtoKP946XNEC3x8=
X-Google-Smtp-Source: AGHT+IHGyVbcG0vLhAhV+eZ25Nd06toC73NkFeyUgjw3avP214nrGFB8qJsgFdwuYb1MR009f2tS7A==
X-Received: by 2002:a05:6a00:1912:b0:686:ec1d:18e5 with SMTP id y18-20020a056a00191200b00686ec1d18e5mr3943453pfi.28.1692243320916;
        Wed, 16 Aug 2023 20:35:20 -0700 (PDT)
Received: from localhost ([2600:1700:38c1:1d7f:f66d:4ff:fe3c:3ceb])
        by smtp.gmail.com with ESMTPSA id j4-20020aa78d04000000b006884844dfcasm3404469pfe.20.2023.08.16.20.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 20:35:19 -0700 (PDT)
Date:   Wed, 16 Aug 2023 20:35:16 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_mojha@quicinc.com
Subject: Re: [PATCH v3 1/4] dt-bindings: firmware: qcom,scm: support
 indicating SDI default state
Message-ID: <ZN2VdHb95tE6RrZy@localhost>
References: <20230816164641.3371878-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816164641.3371878-1-robimarko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 06:45:38PM +0200, Robert Marko wrote:
> IPQ5018 has SDI (Secure Debug Image) enabled by TZ by default, and that
> means that WDT being asserted or just trying to reboot will hang the board
> in the debug mode and only pulling the power and repowering will help.
> Some IPQ4019 boards like Google WiFI have it enabled as well.
> 
> So, lets add a boolean property to indicate that SDI is enabled by default
> and thus needs to be disabled by the kernel.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

The series looks good to me. Thanks for doing this!

Reviewed-by: Brian Norris <computersforpeace@gmail.com>
