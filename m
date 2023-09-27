Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F237B071A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjI0Oie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjI0Oib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:38:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA11D19F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:38:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50348c54439so4169e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695825508; x=1696430308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwuHSbCRREo5aUbdJ9sWu968f7uoQohrIUFOvrQTtAQ=;
        b=zKxUQlKBnZpCQkeLtlV+cRJz2UMkX7Bl16p1rDnUb1nTD75tiZa6Hha5T39t2A4TEz
         wfQ+OdqVVXNQ4AiKriy6Yi6pNietvL2ER8a7W4jc2EbMGtf0IU4vfFufgW/t/rViAFax
         Rs8XT99q7v18PRqGssvflae10RJHJrAmlP9Xb3/5FT5XhVmDaK8irCJqcIpCaIvG4oSl
         1eqFto16dFU4jAnGMW4PMbmQhdY/S5lIl/vsZ6z5VvH761CjLz8JMIGhDDQ97WSJynRN
         g0OXzYgoS4spwpQJv47tKcgEWZWuposuI+nSCt69JDvqwxntP9P0Uca/Ww3vIcSope6Y
         Dh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695825508; x=1696430308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwuHSbCRREo5aUbdJ9sWu968f7uoQohrIUFOvrQTtAQ=;
        b=pNMLHf8zW1E/ou32gVzCqu89gJnkEeTW+t1jMgBYV6Cn9cuy9oxrvLyd/GDQBFp+T2
         rlMCQY58xj3peH5SXLNoZ5IWpEa4pAh2EwZHZN8uLMY4UITX5+VNh4LTdqUviQbQxicl
         NmU/rFE0zuKT7B72t8NhtM/zt1FuHrg2w9GA5tboGGsUShm3Jz1Nsmgqsy+PoFdo6HNa
         hO3rHv+iD9eXQJkvqHgJCmaNnGCcu3r3FD8lunYiDrstLhkOtqodnBYhF87sh0NkLkin
         bSVtzukWrsTy6Et/PJ42DXJyILxmLZQRjve/3rpnsaWHW36SbqKhr53oK5Kez+sprQRu
         1wqA==
X-Gm-Message-State: AOJu0YyiI7+cCaOaegR1T9Ta2H1IPCBmQB8ACqG1JOqD1GHrY0TjpRkI
        EVIiejZzO1Bp7r9jdwOrEIRgPGluEvKL2MrbPOS+mKiueM3tKDBTEoc=
X-Google-Smtp-Source: AGHT+IE0gH7zFleu7xoNGGBjmrFt70/G7NBdkx0ikfMBUwovBQX/1Ee6zh2CoeyoR1CwduIBaNurXRUJ/dV7DFnbRF4=
X-Received: by 2002:a05:6512:3e0b:b0:504:7b50:ec9a with SMTP id
 i11-20020a0565123e0b00b005047b50ec9amr121228lfv.1.1695825507825; Wed, 27 Sep
 2023 07:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
 <169570182987.596431.14062417344858914481.stgit@dwillia2-xfh.jf.intel.com>
 <c3d347a7-58d6-4830-aad4-d354b83f0704@linux.intel.com> <CA+1=6yfmLXJbZu7Gd7cp_HOAbmHwx54aPgozWKBikWwZSYTOZw@mail.gmail.com>
 <6513e6079a427_91c1e294e@dwillia2-xfh.jf.intel.com.notmuch> <CA+1=6yeP6dDiXVQrxMt0AaEF_7S05p4Do67=ysXK-Chfvu-9ow@mail.gmail.com>
In-Reply-To: <CA+1=6yeP6dDiXVQrxMt0AaEF_7S05p4Do67=ysXK-Chfvu-9ow@mail.gmail.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 27 Sep 2023 08:38:16 -0600
Message-ID: <CAMkAt6ohEnYwC8yVzye0F4gApvuyktHDP-q8-p7gJnSAyRMR_Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] configfs-tsm: Introduce a shared ABI for
 attestation reports
To:     Thomas Fossati <thomas.fossati@linaro.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-coco@lists.linux.dev,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 2:25=E2=80=AFAM Thomas Fossati
<thomas.fossati@linaro.org> wrote:
>
> On Wed, 27 Sept 2023 at 10:21, Dan Williams <dan.j.williams@intel.com> wr=
ote:
> > It can be expanded when/if those platforms expand the
> > size of the supported user data, or another configfs-tsm backend arrive=
s
> > that needs that capability.
>
> Makes sense, thanks.

I'm not familiar with the rats eat spec but I would assume the
protocol would acquire more than just the nonce in the inblob.
Probably some combination of claims, nonce, and information about a
public key? Does the specification allow for the data needing to be
signed by the TSM to be hashed first?
