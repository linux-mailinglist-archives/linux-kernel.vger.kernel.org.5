Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F29813402
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573651AbjLNPHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573635AbjLNPHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:07:33 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6538111B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:07:40 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so6953819a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702566460; x=1703171260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9lMPrZwLiHFysOzsWqCBFNM5vjGopX4XPDNLVg4mW8=;
        b=fCGuC6t2nN42viOr2YKBAq0Xo+hUP/amRbiGwv5e07F6PM6Mz+7Qzwi8Fs/ucMcYC3
         jZUtbY7uUH83tmsBWDQiU7PSXgAbdVKVxK+B+ruiRN/iRXF4903eqTh7qyWKvZOzcyHW
         qNNku8yRzWPt9p6JxnHLUDcBeH9ig3E+74EPq+NhnmScZm//E3f+6h4qQH1yGuztgw+A
         wEqLBIA4ektv/MpIXTQc5iUHjld32HE0/V2KWFTYrILpAm1FVwRe/csOy2V5o9g+TWIT
         8P5Ldid5sSWvqZ+MOEw1nX+rfl3Bof3rc60I4FVnfH6ckR8GBKLJf6bggQ0pmgNey/f8
         Q+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566460; x=1703171260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9lMPrZwLiHFysOzsWqCBFNM5vjGopX4XPDNLVg4mW8=;
        b=SByhEHTZUfQY5twX7LfvZKOibeFLaYr1LB6lmWqlNTFekDqUCqP6aSMfEq3DA4hup/
         a04CvllHelWntmGdKGoD2O0vylMVs3MhYQu9SpioOla9Ylz5iqXYirXJAhFlPz3q/khu
         DzojM7QkkfADa/Xwc3wBcPITuy/tSxTe5DY7oJorODB1S8ofOeMeZ3TR2TOoeLdbbOiL
         +S5t/TfY0lzdPimiIveMf/K+kPnR0oY/bzoiokEDtViD8t7KvSMi0Z7cftjPeKTB8WM3
         ddOe6zz0t/cenb9RgdelPdSEj1up/l+ufy9DoZ/XR3SeZrm0+PFGvSlBg65PlSA6iDLv
         +23Q==
X-Gm-Message-State: AOJu0YziVbfbURkFgsC/ljHbvllkqSnfwIVYsj5WCbbX+5X9MoyI/dg4
        ivmNi1ER3sf9WHRIrr4OjPeG75JPdDJmnRwL6tedcg==
X-Google-Smtp-Source: AGHT+IEe4LHmA9Ois0luIdXZnO0T77VZxNQ9yNINBTZ2R/6zYH/aXq6Vfe7Uba+cQAfGN4QaX7I8+rAiF6Etw8yknyU=
X-Received: by 2002:a17:90b:388:b0:28a:f2dd:9441 with SMTP id
 ga8-20020a17090b038800b0028af2dd9441mr1630238pjb.64.1702566459845; Thu, 14
 Dec 2023 07:07:39 -0800 (PST)
MIME-Version: 1.0
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org> <20231214105243.3707730-2-tudor.ambarus@linaro.org>
In-Reply-To: <20231214105243.3707730-2-tudor.ambarus@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 14 Dec 2023 09:07:28 -0600
Message-ID: <CAPLW+4kr=aVjuqGz3ps5f6EzM+QASTFEoB57g+fR7jKH0s+1Zw@mail.gmail.com>
Subject: Re: [PATCH 01/13] dt-bindings: clock: google,gs101: fix CMU_TOP gate
 clock names
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, andre.draszik@linaro.org,
        saravanak@google.com, willmcvicker@google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 4:52=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> The gs101 clock names are derived from the clock register names under
> some certain rules. In particular, for the gate clocks the following is
> documented and expected in the gs101 clock driver:
>
>   Replace CLK_CON_GAT_CLKCMU      with CLK_GOUT_CMU and gout_cmu
>   Replace CLK_CON_GAT_GATE_CLKCMU with CLK_GOUT_CMU and gout_cmu
>
>   For gates remove _UID _BLK _IPCLKPORT and _RSTNSYNC
>

Doesn't it break existing gs101 device tree?

> The CMU TOP gate clock names missed to include the required "CMU"
> differentiator which will cause name collisions with the gate clock names
> of other clock units. Fix the TOP gate clock names and include "CMU" in
> their name.
>
> Fixes: 0a910f160638 ("dt-bindings: clock: Add Google gs101 clock manageme=
nt unit bindings")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

(snip)
