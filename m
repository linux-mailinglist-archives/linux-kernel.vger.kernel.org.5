Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2737DD5F6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 19:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjJaSWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 14:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjJaSWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 14:22:53 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89484F4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 11:22:49 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507c9305727so481e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 11:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698776568; x=1699381368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNbn0nmi0IqVQ4IpWpVaJD6qi4TEeoW4GIXp7b9ei9M=;
        b=3fk3zo8kUYXtJ8ChHhll6/VfrR6CSBgVBR4UsYsKZEql+oCl22c+aWmgr9hYS0kKUz
         7vrEhYnih9w2a062cQJOxHaqXYthboDuhVOQrCnhjT7X7XnQPJTQMkhadSTHbL7Q3Pf3
         m9tI5CLOPOoDB/ApPq6jAb+YDdqaT+cpGrYTIg3FWS48n0RGTmm2bNuvhOpRu9BikIWH
         zwnuetrRrJ2MT3UVXNMMntROIO+AlUkErLldhM+yu4RE7hfUZZUDMZzGaBTDgO61xnjO
         49rxbjzfxb5P4EmesiArNeGC8+1BhboKJPISuTM29YBSIzggjKHPYFw9qd3YM68aRrPq
         SDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698776568; x=1699381368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNbn0nmi0IqVQ4IpWpVaJD6qi4TEeoW4GIXp7b9ei9M=;
        b=V1fGdIQuy3ssYS6ZHs/4uHf5BDRCLYjr8qmvEPjIzHE+YRwA1ptS6M4JJOqbEhJrv1
         f/YOEc3ePTILtfx2f1wfIyLUaGPwBHQm9yyXfvHDNlss77eJNnyGyhsL3PJ3MbCQDkjL
         +RVPKb1Qz0VGyhVAfbkoFJDSZIrDkx4DXtxLUI+nftTYnn6ptsTk58k4izRDC0T1+Wel
         6PMIA45CRPCR4nZSCqZm3ZoTGimSSzjDTL1iWtSBj6gSpE3xslvsyPAzktSeUpX5BKgp
         +D75gCCD1QoyxdcialhtydAgHqvjnp9ig1u5G5HG7SDgP4/QqpF3k1IGQv0QDzx8TZAh
         4q8Q==
X-Gm-Message-State: AOJu0YzWxCQclfYmtIDmBjf2zlOBXxMAxjKXxCYtuEysdMrPTMi+pFjf
        aQvCoevlOKvEIoTsl6fbEyWO3DSMMkGomSFvhKvfRqBCOKn1a8tI4Eo=
X-Google-Smtp-Source: AGHT+IGTXcJrR9gIpZ3pfibK0rEmUHff9yu1VdQGqVTRdXT8TAFS+Nsn3T3EY5iSL3a3rMGVUPH+DJbK+gEBSUwjVEk=
X-Received: by 2002:ac2:5e79:0:b0:505:6c73:ed08 with SMTP id
 a25-20020ac25e79000000b005056c73ed08mr74975lfr.3.1698776567507; Tue, 31 Oct
 2023 11:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231031090613.2872700-1-dapeng1.mi@linux.intel.com> <20231031090613.2872700-2-dapeng1.mi@linux.intel.com>
In-Reply-To: <20231031090613.2872700-2-dapeng1.mi@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 31 Oct 2023 11:22:31 -0700
Message-ID: <CALMp9eR_BFdNNTXhSpbuH66jXcRLVB8VvD8V+kY245NbusN2+g@mail.gmail.com>
Subject: Re: [Patch 1/2] KVM: x86/pmu: Add Intel CPUID-hinted TopDown slots event
To:     Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhang Xiong <xiong.y.zhang@intel.com>,
        Mingwei Zhang <mizhang@google.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Dapeng Mi <dapeng1.mi@intel.com>, Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 1:58=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> This patch adds support for the architectural topdown slots event which
> is hinted by CPUID.0AH.EBX.

Can't a guest already program an event selector to count event select
0xa4, unit mask 1, unless the event is prohibited by
KVM_SET_PMU_EVENT_FILTER?

AFAICT, this change just enables event filtering based on
CPUID.0AH:EBX[bit 7] (though it's not clear to me why two independent
mechanisms are necessary for event filtering).
