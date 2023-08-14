Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084B277BD4C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjHNPku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjHNPkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:40:19 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C640810D1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:40:18 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40a47e8e38dso406841cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692027618; x=1692632418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dLgm844GB6Z3fMbxyoE9eaBHbokNuf66/HVIlaX7MM=;
        b=l+cCvhAB9wOLXvKNN1PPOKmB4IOF9ISPjTYdgNK1gPENn3ARa+QjY3NGulY8JEqZWB
         ti6JsTRa2BVhDdsNmXcMqRrXZvV7ZHQnfUdmgWy2fPU10hIUz8VpfUfq7Ezxjwuy6iZW
         qvDga0XHQiklD2L8nSSrqRSidJke0G5GtxABM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692027618; x=1692632418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dLgm844GB6Z3fMbxyoE9eaBHbokNuf66/HVIlaX7MM=;
        b=Sg0uurldpPOhHBXx8q/ukMqUAgyoddl1MWs6kPc6CVfSb36h7mhCNUiCL9VABmaVxz
         KZlQpViYwgqadbes8a3XTJLlWYB3ioZjl+kLogCMOg5tnEyjEul+RXc7kztW3ZIRzB23
         47tkourawjiMffbclnqFn+ycpl96KwkE3CActQClv92kDJIwIt/9309UhRTyYFJqi4ST
         +nKBCtQomG5bRg/G4BEmN+usJeSDY6nLKfNfXSqw1gVo8DSXXjKUDzueVbCYIochFmr4
         pluJ3xn+5G0skfwdzieBrD2k6VXSyuwhVLF/p8QDKyCxVI5xBur8zGMWEEryeJ3lULAm
         5RlQ==
X-Gm-Message-State: AOJu0Yw9p5O94Fuxy0GNp7vYlHUV90hDuopkNuOSM60PNhomod4BQ/w1
        q/ANve1cN3/s8ADLSu7gKOQHg/EQQNufxN39nduC3Q==
X-Google-Smtp-Source: AGHT+IEgKSIl2LLAEhDVdA1r7ugEIxS2NS6kEgSE2VqUH4qw73YE2OrO5yXybxuZ1jkiYNr+8vQAJw08v4XNzTCFNP8=
X-Received: by 2002:a05:622a:c1:b0:410:4c49:1aeb with SMTP id
 p1-20020a05622a00c100b004104c491aebmr170281qtw.7.1692027617881; Mon, 14 Aug
 2023 08:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230606035442.2886343-1-grundler@chromium.org> <4fa1e0fe-eec4-4e5c-8acd-274a039c048a@ixit.cz>
In-Reply-To: <4fa1e0fe-eec4-4e5c-8acd-274a039c048a@ixit.cz>
From:   Grant Grundler <grundler@chromium.org>
Date:   Mon, 14 Aug 2023 08:40:06 -0700
Message-ID: <CANEJEGt-6+AGGSdZb9OTv3UrBn1fFFqk=A6TdYjBsq4SqTTxsA@mail.gmail.com>
Subject: Re: [PATCHv3 pci-next 1/2] PCI/AER: correctable error message as KERN_INFO
To:     20230606035442.2886343-1-grundler@chromium.org
Cc:     grundler@chromium.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mahesh@linux.ibm.com,
        oohall@gmail.com, rajat.khandelwal@linux.intel.com,
        rajatja@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 5:45=E2=80=AFPM David Heidelberg <david@ixit.cz> wr=
ote:
>
> Tested-by: David Heidelberg <david@ixit.cz>

Thanks David!

> For PATCH v4 please fix the typo reported by the bot :)

Sorry - I'll do that today.

> Seeing messages as
>
> __aer_print_error: 72 callbacks suppressed
>
> but it still prints many errors on my laptop. Anyway, the log is less
> filled with this patch, so great!

Awesome! That's what I'm hoping for. :)

cheers,
grant

>
>
> Thank you
> David
>
> --
> David Heidelberg
> Certified Linux Magician
>
