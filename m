Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D312C7E0F7F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 13:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjKDMwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 08:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDMwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 08:52:40 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B151B2
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 05:52:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40853f2e93eso41255e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 05:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699102357; x=1699707157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Flw7vZposfF8ezOQAkBBKQ76gaOacIHBIh3z+VoINuc=;
        b=s8ktyN0YhRSiZwbZXf2/Wl1vuGTIH0pHsr0eAcQLK/SFs/Xekvw+0M/exsR9rS9Xc/
         p+pfaLUJ0GZDEB3W8oewoCGSxfpf9pprpkZEiD1QxPhObSWzFdI5zznBnrx3pzIe5Tay
         ku/PcaKBnPJwX5h/QOZUhcSprIyH2CO1L0OHo18CHn7urNt8crAkiyubU4krUscS48Wd
         B6BGR7oTYU7rOfYgsrTs8S4AkUGOtY9jsHc63yswVL4SPM1SqVZK25iVZKMfFj1Q6dZl
         RHuJzhHDRdD+IMIfcPELOyJ6tZFI5KsLqk6TJ4DW576wThw5qoUEMtY/HGchMKubUUZ+
         Gz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699102357; x=1699707157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Flw7vZposfF8ezOQAkBBKQ76gaOacIHBIh3z+VoINuc=;
        b=LVHuInhVlZxyNdNe4UolqKZhSozGn21NGXAwTXQZMUHRYLRGsY6K1hPAcLxkRIYbZA
         +rTC84PHsXaP6QvNimrQwvqRHTsxzL3igfQ4akh9Rbn8uVRXl3t9R170C2y4iF34/Mdw
         D38As/5NDLGBg6W6KrHpaI6eo69onmau8lG1xaew2k1KwpPLxFrdDDeNB9nWcwmFZRhk
         4eXQjqdZMVpbZCk5uoI1q9JZPISKJkhClel+dfAgsm32pmqnc0cQvnH9sbW4lY/sd5eF
         aOaOA6bnrGGT+OXuBkdsn9eFfjCa4bo9RgK4StKmgUhmtHwhOED324wQM5rnP2hzDGji
         dDGQ==
X-Gm-Message-State: AOJu0YwrGCGW06M8wqjE+KzKRBt7ClFgJOlo/QRX4Td4hgXrYC1mjtnv
        WSktp3d1+Gm80J+WRbGF1YzdK5D8I2BorjeRLZU25w==
X-Google-Smtp-Source: AGHT+IEFpVoIAL3pQCTnVkmFsoixSOlqR6uSd2KntS4PaOIRWms+TNlmkBFhh5ndXwX3CoO+p9QkdEz+OYy5AcW3X+c=
X-Received: by 2002:a05:600c:929:b0:3f7:3e85:36a with SMTP id
 m41-20020a05600c092900b003f73e85036amr44095wmp.7.1699102356618; Sat, 04 Nov
 2023 05:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com> <20231104000239.367005-8-seanjc@google.com>
In-Reply-To: <20231104000239.367005-8-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Sat, 4 Nov 2023 05:52:24 -0700
Message-ID: <CALMp9eRZCEuCQHH7G-ZS6U_Zi768qcdZmwPtmNgxMRNjppnKbg@mail.gmail.com>
Subject: Re: [PATCH v6 07/20] KVM: selftests: Drop the "name" param from KVM_X86_PMU_FEATURE()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 5:02=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Drop the "name" parameter from KVM_X86_PMU_FEATURE(), it's unused and
> the name is redundant with the macro, i.e. it's truly useless.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
