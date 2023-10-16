Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC407CB5BF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjJPVy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbjJPVyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:54:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A99FC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:54:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so8731803a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697493262; x=1698098062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sFyszUAKH1Bi59GLrKaH1xZ412ynyNyWfhIyPM619dM=;
        b=dye2UvF1lKkLi0fV3wHVTP6JUvjcdYunlfnQzKTUzXyrJbQd4sWyBw5B1YF8VxTgM0
         gbVwGMogydnomEriyQ/r0zm3ManSGscCp/qO7p/dCuqZz0tQezxkjVOgF7U8hI7Xnlix
         c4d7s2iyCm9vADjIYnBPN5QZeFASBv7lAvIL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697493262; x=1698098062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFyszUAKH1Bi59GLrKaH1xZ412ynyNyWfhIyPM619dM=;
        b=FrhUPfBseEc4XANVRZHZqivb0ZCqdCjXqAUNXVVkseAxbDjDWDPBWuf7s8gFRMwLpy
         v7a4CyOuJeCzD8Cu3UOc1BHSJBmRfiViEHStBSafVAnfLYg2x/nOx8c5CCbvC6Lsay8k
         odBi8TsTIimRFqP2ywMhxVtlcR+MzpmHrGa/b5nPA1cIGsYm/23PzYw8t3EY8mhiRapR
         rl5dtr9MHRn/YE4RhQMOtSBgJVuFU7WZop1UGWn5NpBURjmqYijV+hp7TRKo5bkNcmm5
         lFuE9UkZggYsuKBjt32x55UQoTak/8X9PWEbPs/J/td0rccnJYAAAlZnja3BNDGxYJlO
         6JZg==
X-Gm-Message-State: AOJu0Yx8hlbpeVbuol46HOlvQgAPZzqIrnnhTaEY5QstwUkRYC+dmjIn
        uPd5Zw1S+m+5kA56z+V7cAYGv4oxAbtEeyRYulv09rhjcXV3yd6kKBg=
X-Google-Smtp-Source: AGHT+IGZoGGJeNshHE+uBukBw1GOLWeEgu2vwWq8BjnV21H2X6/a8NzxZphGstDjGzZP8Yp311u7fu7RX+UlFVrwkP0=
X-Received: by 2002:a05:6402:34d3:b0:53e:467c:33f1 with SMTP id
 w19-20020a05640234d300b0053e467c33f1mr440773edc.8.1697493262341; Mon, 16 Oct
 2023 14:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org> <20231016195728.GA3574754-robh@kernel.org>
In-Reply-To: <20231016195728.GA3574754-robh@kernel.org>
From:   Simon Glass <sjg@chromium.org>
Date:   Mon, 16 Oct 2023 15:54:10 -0600
Message-ID: <CAPnjgZ3xo6Rz8dGe+UtNxv9O96sbaphx0DYkKcRNd1m2nozQ3A@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] schemas: memory: Add ECC properties
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        Maximilian Brune <maximilian.brune@9elements.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        Guo Dong <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>,
        ron minnich <rminnich@gmail.com>, Gua Guo <gua.guo@intel.com>,
        Chiu Chasel <chasel.chiu@intel.com>,
        linux-acpi@vger.kernel.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, 16 Oct 2023 at 13:57, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Sep 26, 2023 at 01:42:38PM -0600, Simon Glass wrote:
> > Some memories provide ECC detection and/or correction. For software which
> > wants to check memory, it is helpful to see which regions provide this
> > feature.
> >
> > Add this as a property of the /memory nodes, since it presumably follows
> > the hardware-level memory system.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v7:
> > - Drop unnecessary |
> > - Add a blank line between properties
> >
> > Changes in v6:
> > - Use a number of bits instead of a string property
> > - Fix inidcates typo
> >
> > Changes in v5:
> > - Redo to make this property specific to ECC
> > - Provide properties both for detection and correction
> >
> > Changes in v3:
> > - Add new patch to update the /memory nodes
> >
> >  dtschema/schemas/memory.yaml | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
>
> Applied this patch.

Thank you for your help and guidance on this.

Regards,
Simon
