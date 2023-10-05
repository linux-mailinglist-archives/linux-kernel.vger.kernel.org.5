Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4EA7BA920
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjJESbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjJESbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:31:34 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B166793;
        Thu,  5 Oct 2023 11:31:33 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-57b83ff7654so76636eaf.1;
        Thu, 05 Oct 2023 11:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696530693; x=1697135493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9EgV7tZVbtR5SndWMS10yNqMtDpb2mLG5N2vupKW7s=;
        b=VsJrgtg4WjznYqh9y1GcAosYcY1+6FO0e79HrpQfsNtU8JlqEDJrVRc6/bZ2MEQ47N
         AGMugyyaQ6pXC5Iv8TJnG/Md3p/HaKq/3P6/9vIIiRPA+smY/a+HPLEbC/VsYNxaNyP8
         2tLRx8CRQg81fIRGAEbD4fb7M/d6F32WtWrPDEz742Qa0u56rni6Cl4UDdIuypZ9wTda
         7PBXV2uLlDHQ6VKVwE4K9z5sqgXNM80/kwrln93LZweS/fQu0IsiT2hzuH3Z5qonllE7
         OVZabHUvGfNI+29MgJ5rp5Ksjt9LMnHDR3GYlYoKIE82VfgDGK+BQnjR/Ih6aQlVRXBX
         oE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696530693; x=1697135493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9EgV7tZVbtR5SndWMS10yNqMtDpb2mLG5N2vupKW7s=;
        b=DJVnL7TV1Zi9cBhAZaHvHGlAgsDNxtZ8eEnEHWzzYsbdaXSbazLxr1TWnut2x1wYKg
         P6SshzyVyHGLbUVCEBOkUiwd08gpUMYztm5VGFGpM69ZTXvFdGAlG/3uZk3N0WcxA/W2
         hhqFPSNTMIKAy2ecbgpwtTQ+DWY5T5J3tigypk8FWOyGf4dK2SEV/pzDC+sC7CUlfP0X
         p34ILk66nWnhO2MefdOPJDwSCaptBjN+xCRk0x037pwd2dIpyh0YPlfB7L4OSSp4AjPm
         eGykgeQiREXxw8zD9ftbphfCAbkldyYJdNMAlwHvdDV7/8XKoocbo+hWXo1I6T+fw30y
         k0Kg==
X-Gm-Message-State: AOJu0Yy3+0wziKxP4FWS8NqLHW6yS7GONlrAkZ45m6IY6jiLZtnTLLLw
        tkd1jYgmAjMBDaETGOdly11EDBe2dY7st0M9B8U=
X-Google-Smtp-Source: AGHT+IFvd2hc7PErEbHkKVIONk4K3gxIbSTgtgz5g+KRd76BkIjZhSp6A2x3i4wHwZb2i0rlrr2iUCEK8vskipLHsj0=
X-Received: by 2002:a05:6358:e908:b0:147:47f2:2d54 with SMTP id
 gk8-20020a056358e90800b0014747f22d54mr5444671rwb.0.1696530692891; Thu, 05 Oct
 2023 11:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231004234657.44592-1-aford173@gmail.com>
In-Reply-To: <20231004234657.44592-1-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 5 Oct 2023 15:31:21 -0300
Message-ID: <CAOMZO5DQmw5y8mnk-tUqTtkeJpH3xcvOR9HtK_FYFjB1H=2fEQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] arm64: dts: imx8mm-beacon: Migrate sound card to simple-audio-card
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 8:47=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> Instead of using a custom glue layer connecting the wm8962 CODEC
> to the SAI3 sound-dai, migrate the sound card to simple-audio-card.
> This also brings this board in line with the imx8mn-beacon and
> imx8mp-beacon.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
