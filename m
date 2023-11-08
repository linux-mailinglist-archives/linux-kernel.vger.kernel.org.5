Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EE57E4E43
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjKHAvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjKHAvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:51:08 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8960C101
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:51:06 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b9e83b70so2313057b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699404666; x=1700009466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAswuKJcd6AlQMRzBy2s9uqCImq2rSuUz85xbiYFFFE=;
        b=B8vWVlrXRaXCQUJ27IvE8OA30ivGjhelEWD+cmu0zbbzdb1tjAG2Goe5Rahdz5GGKz
         wVafIONj6ocguiP/EC4qMDshy9nhAzX6Qm8jEUyYedpv7x9Z0k87+xnaHwA0X/jyC1Bl
         6UGiP2oNGlwQcy8qJNkkcWTIBJaF9DxwXr7oWtjbhiLvT7J1hLdOUlPzoaBa9XnB8siX
         ISgKpcD0ZtFFiNR8XnwC30bVYZhx4uDmhLc6kkBc36QQ+1GKRqxhXSMY+M/9To19N+lY
         u+LFvv4EGBinWiSAgBK3KtMlSO6oAj052VQCUkhKK6T7FWhuXooBYD8EgB6MlDpRqByj
         CXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699404666; x=1700009466;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MAswuKJcd6AlQMRzBy2s9uqCImq2rSuUz85xbiYFFFE=;
        b=M9rPo7fCDsO2G/ELWTs53KTcQku7hiXKjiZ509vDuUdlsIwGeDrJEufURj1lf3kPDE
         4AQTGE5spOwoGESx+uTD1B1vf5GeU3CN8tfvkoxSLvbW5NP7gPO2E/48FoPzOTrdB/O2
         zP1Y5Wqb9mRctNlW3hDgy9nHQZD2HcIwKhZKO8xDXKveetLwuQ6Gtn4CcTg8cZk7wmqJ
         SLcD90rDY1goMuxDldc1MreFP1lIkay7eam5PjCGsl2qw5adMR/sAbI2OpDn0DR9orte
         rSzlrfq9NXVi5YDBFo2nQ0CRVVZ2QkVtNhisMPl6PR56JqXa4a3cv2HgVZ22NNZ0Af09
         ihtg==
X-Gm-Message-State: AOJu0Yywf9I7h2ABeQPGbDVSLdxHsxKcD0w21rKYythu7UUaQ0WhJLTZ
        iuxLOBwIFrYZ++gtTVi2qcdjgUVI2tg=
X-Google-Smtp-Source: AGHT+IGKJr5DObBJmipJMinpzOP1HKYoNosAsft8sFHuxt2lp8/YQ/OIVwc55JA720d1mQ34cqOsEEBdzek=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:88f:b0:5a7:d45d:1223 with SMTP id
 cd15-20020a05690c088f00b005a7d45d1223mr107627ywb.3.1699404665831; Tue, 07 Nov
 2023 16:51:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Nov 2023 16:51:03 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108005103.554718-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2023.11.08 - No topic, but still a go
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No official topic, but I'll be online.

Note!  Daylight savings, a.k.a. the worst idea ever, ended this past weekend for
me, so my 6am might be a different than your usual time depending on where you are.

Note #2, PUCK is canceled for the next two weeks, 11.15 and 11.22, as I'll be at
LPC next week and OOO the week after.
