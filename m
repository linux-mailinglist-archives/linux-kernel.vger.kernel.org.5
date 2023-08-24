Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD89B786490
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbjHXBUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239070AbjHXBUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:20:36 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F5610F4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 18:20:32 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5657a28f920so3820045a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 18:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692840032; x=1693444832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s+YJjfTJ2CkuC+9NB6jQl7KJU8EcbLSznIZ1SQdS0Ww=;
        b=RZICqqKsIMzwKfA2Ueox9ribDm0pr/+dwRryfn2hU2S8m0nmU3aNn4IO0ZhX0BXLDJ
         yr8F+ynlshV+pedCIvdzukN4AwNiUuomEvmtbqILCrEKgOqVrVz7CmUbuizI4z0aY/Gu
         PVdS/6daQkW5nw603RNSDx+U0plzgmEtdmrDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692840032; x=1693444832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+YJjfTJ2CkuC+9NB6jQl7KJU8EcbLSznIZ1SQdS0Ww=;
        b=fHRozYFlSgQlIJjSnLhn3wyfKAlScqgILS3QrK41pL39XMLgSzyFRbkzsvPTr7GfPV
         JmmN2kzdSInTP8xZWwu4lb6LvvLUW+co3azvJOwnaBflFrvf3WPyOk5jGOjKx4tGefwb
         xHCvshw9rJMKBzyP1DpqDt4OY28nl/MVA3AOrUAhkLTfQKm/MPSyOLMktRMuEyePZVNV
         Q6Wb7/QHomGJTZWoGllppMJvpd2g40q3npybAEjVqyu3b21tXr8dEMjhvXm6xrG2K788
         WfiRolljvaoCG6yyRsRXlae865zRuDxILAOau4vNu80y/jrv7PAm0HpcuE1yDOvxcrYJ
         OOJg==
X-Gm-Message-State: AOJu0Yzk9R+Icz5NqxbGkxEQYlzg0tVkENyAv2S/Z/ICsHGiswh3F3Uw
        MHHFVfg7AJYtxlW9kshjxsg/Gg==
X-Google-Smtp-Source: AGHT+IHAcjLDuiJWXzPmDLQ/QUBMiQMCiXx6OhH0ZfSbdOPcNx64pyF/2QMK8CXZTvIfo5LYo/kDYQ==
X-Received: by 2002:a05:6a20:1046:b0:137:a9d7:de12 with SMTP id gt6-20020a056a20104600b00137a9d7de12mr11688917pzc.59.1692840032202;
        Wed, 23 Aug 2023 18:20:32 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001bdb167f6ebsm11504470plt.94.2023.08.23.18.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 18:20:31 -0700 (PDT)
Date:   Thu, 24 Aug 2023 10:20:27 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ying Sun <sunying@nj.iscas.ac.cn>,
        Jesse T <mr.bossman075@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Tomasz Figa <tfiga@chromium.org>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] kconfig: introduce listunknownconfig
Message-ID: <20230824012027.GD3913@google.com>
References: <20230817012007.131868-1-senozhatsky@chromium.org>
 <CAK7LNASJWKSsdzn5ccgWaC35-XvHGU7pnE6C=eZFDbqrrghtdQ@mail.gmail.com>
 <20230820024519.GK907732@google.com>
 <CAK7LNAS9KC1GjPgadMEivSpy4TMYU8mQ+BrtfJpNs2kvhK18yA@mail.gmail.com>
 <20230820072119.GM907732@google.com>
 <20230820073332.GN907732@google.com>
 <CAK7LNARTZXvWD8PrA3bC+Ok7LK85qO=pkMs4kOPGn90OBooL6w@mail.gmail.com>
 <20230822061203.GA610023@google.com>
 <CAK7LNAS0qEZk+xAq84=7SuJSQz5F3dNBjYKPoeKTd_caq-QMKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAS0qEZk+xAq84=7SuJSQz5F3dNBjYKPoeKTd_caq-QMKg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/24 10:00), Masahiro Yamada wrote:

> For the MFD_RK808 case particularly,
> I believe Kconfig showed MFD_RK8XX_I2C
> as a new option.

I think there were some other unmet dependencies for MFD_RK8XX_I2C and
I don't think the new config was shown. But even if it was, we still
would have no idea that this meant "MFD_RK808 is not available anymore
and the corresponding code won't get compiled". So the "this is not
recognized anymore" is still needed and is quite helpful.

Would you be OK with "list missing" being a warning (not a terminal
condition)?
