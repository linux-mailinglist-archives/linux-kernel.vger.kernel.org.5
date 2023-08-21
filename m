Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B79C78264F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjHUJcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjHUJcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:32:12 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA68E4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:32:00 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40c72caec5cso373121cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692610319; x=1693215119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laAe1Bo4NZ8AdV8W9Bh3WsToh2Bjfo6A1xgGVoYjoyQ=;
        b=dLa7m7YOFXaI8f3LH4rmihbtsr0xg3WAuCXck0gHdLLzonLi1YVjZzMuNX+7sPul3v
         gSojDkMsPLSogLdEbUM6mySPFZTo7tXT8cWUxXiHJM18TI0HXs10W24ppFH4eywBoQ0P
         SjjvA3ak2E/K7OTROdIm789q+Hj60/+PZwxX479WbHalkuq7FfhUWWYDdXDgkqYIa+Cq
         IGfAuXNtJSpMseZUcI1g7EV9hmyv4X5DqBtA/QdTWMU0Zx/bDqPjei50o3dF87DSfPqB
         U/vqX4L71zson4Sjp52xAf8fD4z3DJHLzscqUpLgHRTMOQ+8HbJfPyBAOJaxB/n69CM8
         P/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692610319; x=1693215119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laAe1Bo4NZ8AdV8W9Bh3WsToh2Bjfo6A1xgGVoYjoyQ=;
        b=bPuH8tHPSO1lx9gaSXzvUaRFRL4kZQXWnpYIIXyEC0SquTvUcQizZ2pCSInvjIAwmE
         1j6h8depKS6OtpScg7Ee/ZHRvmje21c7HEBqtIj1hFugeZr45bELOnecWgxjuXPAc5mt
         Ma2qXUl8/7dpAyg8ZFQCWvZpU2xncNyo88joREI63sr29fYNIC+dTkIlLQAsNO+NaSAa
         TnZA21UK0lRlatya/sgcr0ItRqTBfE1k40RFrwz56PcQ4NalZQBfL+idZ0as/9Nq087D
         Wn1878teIFU6DaKVWJU0l61BdFa2cEq62fl9nI9DuwHrg+qyObiO+FJnABqMjoFFIScw
         xLfA==
X-Gm-Message-State: AOJu0YykRXHv7qF3YcSxTAjcSN1LJjzCsH8NW3i6O1QZQBg4zYxAGn+U
        R/cK33pOxvro+vg1eXXjw5w3R+Tg4at0JfCN73Xu5A==
X-Google-Smtp-Source: AGHT+IGsyBh91ymEq6DEeNpzIVHw7+WcMyX8lYQffIO3qca7jbZOrPGYPHweVK6U14iNXO73ZrJVgVuQHp3pHi8oVcE=
X-Received: by 2002:a05:622a:1801:b0:3f0:af20:1a37 with SMTP id
 t1-20020a05622a180100b003f0af201a37mr510984qtc.15.1692610319419; Mon, 21 Aug
 2023 02:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com> <20230818021629.RFC.v1.3.I326c62dc062aed8d901d319aa665dbe983c7904c@changeid>
 <ZN5pK03Drao/egeF@nvidia.com>
In-Reply-To: <ZN5pK03Drao/egeF@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Mon, 21 Aug 2023 17:31:23 +0800
Message-ID: <CAKHBV27k8F0ZLy=RA=WhjJ7+C9JMHRRnKs=4W4pJMNmxrMEXxw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/8] iommu/arm-smmu-v3-sva: Allocate new ASID from installed_smmus
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org,
        robin.murphy@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Aug 18, 2023 at 2:38=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Aug 18, 2023 at 02:16:25AM +0800, Michael Shavit wrote:
> > Pick an ASID that is within the supported range of all SMMUs that the
> > domain is installed to.
> >
> > Signed-off-by: Michael Shavit <mshavit@google.com>
> > ---
>
> This seems like a pretty niche scenario, maybe we should just keep a
> global for the max ASID?
>
> Otherwise we need a code to change the ASID, even for non-SVA domains,
> when the domain is installed in different devices if the current ASID
> is over the instance max..

This RFC took the other easy way out for this problem by rejecting
attaching a domain if its currently assigned ASID/VMID
is out of range when attaching to a new SMMU. But I'm not sure
which of the two options is the right trade-off.
Especially if we move VMID to a global allocator (which I plan to add
for v2), setting a global maximum for VMID of 256 sounds small.
