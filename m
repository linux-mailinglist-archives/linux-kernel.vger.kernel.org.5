Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C26E75A7C4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGTH2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTH2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:28:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51DD2107
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:28:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3159d75606dso351031f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689838116; x=1692430116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XDAr6SeIqeudoRQHCph90+wHKBmBfV4FHrTuD9Domzc=;
        b=biH/V0xIkYHa35gSz4fYP6fcPbJlKnk40UeOG3lvXapq0IH6GL07goyMcBtHs46M0N
         8QN/wWBQMI/rBU3jBvQCB9RvDZkEzpn3YyJJLNaNrE4v3e1JJDu2PeFbPpOJuP3GedlC
         Uj65AyamA+Z3wnNQrczKZCaAE1yoBnbrwnWoxvJaoGn8Hptn0q2nZEKgU0j2EVwS4mD0
         vDEiNH7MbUGQxt9q8kPXnk79MNvpEBBzhRT+iiJgDUwvHaImTMsQye3Q1bP/g0gy4IGG
         +y1cpqZkrwP+eQJDdg72bPVw18YjCI36o8hiZpfPkisJFliA4dR9uIubuuyRgx3J2an9
         pIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689838116; x=1692430116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDAr6SeIqeudoRQHCph90+wHKBmBfV4FHrTuD9Domzc=;
        b=WTeD+5R7OmasRZHuhertoj8SgGpyRVDuepbBaNdJ1It/toJoFbO3IX3efRhwT9g7fW
         jiKz9TlCFfzNuYOVfSxnbNLfI1SMi3ZRWKXsuyRKMBCiy14P45GICbiUFZsqyruG3IKB
         C6ZIVy690sYPuib5OIiycA/nagM48Xo+gMRs1oQpWXy1GUYeCw2CgbwDo4LQJIx6Z1+r
         mPF3spZ7GOTMTPQITT3UamBquGTQaJUkFOBhJYB3XUsG5CGaMGEuA69z1llXhMEcK8zu
         AnZD8LURgMp6tvUQrMSvOKXPyNsJU3WZHE81PAV9/Mb0i5SM2wvIJvSlS/FyL7kugy9M
         pCWw==
X-Gm-Message-State: ABy/qLYrKBm67S0THprfs9P42l4DYmhDVvBrSWsvnNdPDMRsVPfECyK1
        h7ckG/ZktDQPqlyqgkyNysdLcx2VsDJIxjEu69jjr9vkiVGgXQ==
X-Google-Smtp-Source: APBJJlFs6dNUfd8h4TAD4VMTFNII7qpzNZDhCEY7jz8Ef6/esKw4D8dXqHBf+PSbusKdABOqR/eHHMnB4bS7YZE33UI=
X-Received: by 2002:a5d:63ce:0:b0:316:fe45:1515 with SMTP id
 c14-20020a5d63ce000000b00316fe451515mr1561703wrw.21.1689838116032; Thu, 20
 Jul 2023 00:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230629182941.13045-1-dg573847474@gmail.com> <4fb34b91-13af-cfff-0118-0f263e0e0d27@broadcom.com>
 <07406ab9-fbb0-4f98-56b1-0c64b7e695e1@broadcom.com> <2e87058c-839b-5b28-62e1-896d1e49fb57@broadcom.com>
In-Reply-To: <2e87058c-839b-5b28-62e1-896d1e49fb57@broadcom.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 20 Jul 2023 15:28:24 +0800
Message-ID: <CAAo+4rVc5FXXRp0SnEBikAkRQuFPPKDK78ApF7qOUiottVdyAQ@mail.gmail.com>
Subject: Re: [PATCH v3] misc: bcm_vk: Fix potential deadlock on &vk->ctx_lock
To:     Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, desmond.yan@broadcom.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Works fine.  Corrected Acked-by and Tested-by below.
> Tested-by: Desmond Yan <desmond.yan@broadcom.com>
> Acked-by: Scott Branden <scott.branden@broadcom.com>

Thanks much for your effort in reviewing and testing the patch.

Best Regards,
Chengfeng
