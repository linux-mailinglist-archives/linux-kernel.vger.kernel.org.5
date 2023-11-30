Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF1C7FF7A3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345965AbjK3RAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345798AbjK3RAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:00:36 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E3810DF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:00:42 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-da37522a363so1073723276.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701363642; x=1701968442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Hky/KzjhYHUu4aS2qxPMLUaAm2fO0s9p6joqU6jYEY=;
        b=YNyyzKCyfsDJEM1CKQHQD+BXpNbAgAxMWeZ5wQamWzzifpi6ycxP+xC9V+xWSbJWEr
         JA0w9sXn1E3nXDzWK5gyQphUs+RGlDzIWuC1qlvh18wfisjwn3Pj9ThWk3bWgtP4HkJP
         5KIAYsUWSk+OI5VVRySmF2laOlvYPrt8cex+kioYbE5n7isyGBdBcLq6WxLhuAnF+joC
         HLxmJ9LbtgjZ9y8uh3MoGFn2xNQByszDC1T6V9yFNClI7uOLVkUWY8AhscSga9ltQyUm
         UHpbvPlQjLYjKqNzH79ApOgtyPPxsQaOES2RMnt2vFuQRdkvLY/ewrOiP/BQOhAxW6qd
         c/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701363642; x=1701968442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Hky/KzjhYHUu4aS2qxPMLUaAm2fO0s9p6joqU6jYEY=;
        b=TOXZCb1ndLe3+bXQrFZPwGSf7lmmhVeKlyzIhdhp2V/FO+f7KT78MHEJjgVjOdIefP
         Cq5Y4eJ42TzwW7WlqFlakdBFObnyQv4jT2nQGtikBw1HOuMCRfOlFP3NfzVLGuYy2pBw
         XrLsTT83d6vSwc9ysIb2lKJTW64WKHEV//tPUstlkS3avdpgQrS5pxAlpmSw1WiAi0iO
         Z2r60sFuLa3nc6oLHxQiDM6gOYW8RPFhFh6oMXb+tIjiqvymS7LPwM4Oshb2X3sPSD25
         XC4MOvMWVoW+VCVbvUVXiTBxq6Q2QsRGSgSrHQhzkK8sj90/Vel59JpGSSci5PSLsEE7
         5D8Q==
X-Gm-Message-State: AOJu0YxUG8+pyYAMRH9ljxQOUe0dasNWXYponG9pGVarLh98x7xPqJUa
        DxvQBk8aNEgyPuE07i7Uq6Sc4CibXb7Po8Fj5ql8
X-Google-Smtp-Source: AGHT+IGWeq1u3TY1LG8uphGYW7WlDE5cBTGD3zQC5Dpze48seToweLISJPvMV/SevTHuqk4ZZoykKhlfrHXvZ4kk9d0=
X-Received: by 2002:a25:4f05:0:b0:db0:2b47:aa1 with SMTP id
 d5-20020a254f05000000b00db02b470aa1mr20617458ybb.40.1701363641760; Thu, 30
 Nov 2023 09:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
 <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com> <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com>
 <CAHC9VhTTKac1o=RnQadu2xqdeKH8C_F+Wh4sY=HkGbCArwc8JQ@mail.gmail.com>
 <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com>
 <CAHC9VhSAryQSeFy0ZMexOiwBG-YdVGRzvh58=heH916DftcmWA@mail.gmail.com>
 <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com> <7cb732ea42a221b4b8bbfad941d9dec41a3a35fa.camel@linux.ibm.com>
 <CAHC9VhS28XuVjNX73H9qWZibObCxKCx_M3omQu9+5EdourUc+w@mail.gmail.com>
In-Reply-To: <CAHC9VhS28XuVjNX73H9qWZibObCxKCx_M3omQu9+5EdourUc+w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Nov 2023 12:00:30 -0500
Message-ID: <CAHC9VhRpNc2ih3iwc00sNGsgM_Ogqf8_r=kLGp_Q4+LdAz-J1A@mail.gmail.com>
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, mic@digikod.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A quick note that I'm going to have some networking disruptions at
home and email responses may be delayed for the next few days.

-- 
paul-moore.com
