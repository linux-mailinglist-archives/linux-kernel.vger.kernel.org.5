Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68D077FD76
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354203AbjHQSDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354208AbjHQSCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:02:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981E82D61
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:02:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so1142a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692295354; x=1692900154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r/qGeg4cPGs4DXbdr8hhHcyEvjSqnTx2KFg+VpsKwUE=;
        b=AXXw8Nnxbz6+54+479R4k+hFOuC9K6wrzxX5cHvRRwjI4j/HSyo0AVVwJrMLHj1kHv
         WVn72NNEpi8BbghYqy4Qp9DtE9NRxzq1iRkh/tegUNdAs2UoZvsJghyPMUBEA4LyoVrp
         tSgXPvLljcczcS7gcaGDHV8RSFwPry1Se5WXc2iJnqYC99ELnu5DvMB1SU3zLsrjbvmP
         q5ULqEjLFQPBLbjewWLK8ac9n4yTu8pHBHRzZGPPmT5JjpAhqSZmUB23pJJZkuTojuwb
         hoBkJNLYy8hiXQ/bu/u6v0WAMo3VVf0uOrkACimg97+PWSYw49VXI+kjtrZo8bngV5oZ
         C7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692295354; x=1692900154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/qGeg4cPGs4DXbdr8hhHcyEvjSqnTx2KFg+VpsKwUE=;
        b=P+LP+plDOfxlR9o17/G2CpcpE84KABPZIRB0AQ4QejkCJqKnU4jWAaM6X1FD57/zqM
         KMstwiXT6FM6hOOmboRq7ZJlzi61vdVAG2HdMI0UO8xRZRsuyOo0D9jpkdsNQclfB3bX
         YeBhqodT2tvgdhZWT0ZHcOJfFy6qkP/MC6nH2Fllbfh9rkNDkAgFtVA+lEMCQMlrWhA+
         32T2SrQJrbVv1lrjqgJnRVnv/uxn8oxvNsrVtxzXOPUj5Tt/NleYB9PpTxXoli08rltA
         vqgZdYzswC0kl1cUFLNwREoecUep3r7xqC3ymY+tOHIf2rD94nXFl2JfdzpZ7reD9Au+
         WMbQ==
X-Gm-Message-State: AOJu0YzgdrHIH7ID0ZZQAHI3/YxNgv7btcA3HSwgHzRhGdXWvM28KZ5d
        frA3IdHcay06vkU9NJSzTURIWs4u5vA1TYB6ulwp4g==
X-Google-Smtp-Source: AGHT+IF5eMi5m9LqduWTyQd1IaleHMKqB0gBifE5ynXQwQisKdeF0nRDyOVxLzIt37MssoxJmAVWhF8tAQoohBh8cxE=
X-Received: by 2002:a50:8e13:0:b0:525:573c:6444 with SMTP id
 19-20020a508e13000000b00525573c6444mr9899edw.1.1692295353993; Thu, 17 Aug
 2023 11:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <12a12721-239b-457e-1ff7-f98c02cb7abe@intel.com>
 <20230816201700.589822-1-jmattson@google.com> <20230816211821.GUZN09HTGo+yQ2+jd7@fat_crate.local>
 <CALMp9eR1Ub78MZwdZn178d4OXPu3Au=faBgVGe6ty6ARV+nK8g@mail.gmail.com>
 <20230816213025.GVZN0/8cjvLebNANTq@fat_crate.local> <CALMp9eRT4xCrK3Up_1bQuBZNd_2ZKLFqgamvP4BtA+HuC1driQ@mail.gmail.com>
 <20230816215854.GWZN1GniMWRL0GnyVh@fat_crate.local> <CALMp9eSbdLuUr9ZvHOA5=vvvA58S5j+cePNKxbx1RxEprRMLZQ@mail.gmail.com>
 <20230817154044.GGZN4/fGMRuvFVtPjD@fat_crate.local>
In-Reply-To: <20230817154044.GGZN4/fGMRuvFVtPjD@fat_crate.local>
From:   Peter Shier <pshier@google.com>
Date:   Thu, 17 Aug 2023 11:02:21 -0700
Message-ID: <CACwOFJSZ=WV1UxcZeCjaKyPk1mQPbra6k+Ax1kyCoRwD0fws4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/microcode/AMD: Load late on both threads too
To:     Borislav Petkov <bp@alien8.de>, tglx@linutronix.de
Cc:     Jim Mattson <jmattson@google.com>, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, stable@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> tglx has some patches which verify what has been successfully loaded where so hopefully we'll
> be verifying more in that area.

Are those ready for some early testing?
