Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FBD7E48B7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjKGSu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjKGSu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:50:56 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADCB99
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:50:54 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id 98e67ed59e1d1-2800bdf888dso4617055a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 10:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699383054; x=1699987854; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a5/WA6a8L/bC89Es8MR4LSB2IBSHjNn0z8GWYcaUP84=;
        b=ICLtyrQA8GK7QUJBI6cX7VG0Q6SfoUruQDrNpWQ1ce6NpBvpHv74sWex7uQmeX/4GG
         U0JdGs2lOtG9TZ1Y9+MlIp7ugNepiWoWzr4ApBzxXiKYjJOorGxMOIh/uV+gQN+rLNWE
         OdEN0+DeatzEtED6j5Ong1hjIhJ9cEquU1z9bMVdj2yvm/r1YbF1zkSpO6hwT7HP+4/C
         4/vWkHc8uAtk6WoHQ0o2NHGv/QGFCDavQlncSdhYiEdZTnCAhF8ZlsvbJl81sYbPY1Hv
         W17Zhb0FrmCO1AvywvH1U8X+o9SdfxdV1Dpsfag/fzk+BKbGKlpy/pfQ4u46Ml6/KcAT
         dO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699383054; x=1699987854;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5/WA6a8L/bC89Es8MR4LSB2IBSHjNn0z8GWYcaUP84=;
        b=Os/llN2sTaECAaHgOCLAKMw7kpzAk4pPV84q8khB96VnjnDnUwJGx4vEtNxHYicihx
         YptlGfywyhhBWRxrA4emYC2VFSs51RxLHNCdAB/424w7nJ84ItnlqbxAFh/ch22crUlD
         lIPj8YX4KaicDhO2jmpvgB2wiGHTfXWWFMQsijZlydr9eRJN4nM8wep4f7LpKWlmKtIE
         xkKA1aqZFeJxiNG3u7QFh+C061/jJDJwfWs1XptPxsMHKkg/QHJOfhTUf4WFKI9xlfbb
         RpNWZn7POPVM5NxeSfMJIUKujiFCNdpvF5b/eqPKiC5/MtpURBTGPvYO92OqQhMDNGo6
         o5Jw==
X-Gm-Message-State: AOJu0YzDjrrn4R8IeTm9FvMoVH2DWnZCa0AjkYhAqmecR4+FYwe3jqPO
        /454IGtappNHkZfGLEoUUKez/GyWbkXQg0CBbPI=
X-Google-Smtp-Source: AGHT+IFrSkLRyXGHgESRiq4B2Mpi+QDvY+k7zeLmCwZi3Wyy/WE4ZAuozWrnMNN0mYokVNmq075IA0H4R5rnn8AMNAI=
X-Received: by 2002:a17:902:f7c1:b0:1cc:4810:6f2c with SMTP id
 h1-20020a170902f7c100b001cc48106f2cmr4078288plw.33.1699383053614; Tue, 07 Nov
 2023 10:50:53 -0800 (PST)
MIME-Version: 1.0
Reply-To: dear01776@gmail.com
Sender: bintousawadogo4@gmail.com
Received: by 2002:a17:903:2596:b0:1b8:9bba:768d with HTTP; Tue, 7 Nov 2023
 10:50:52 -0800 (PST)
From:   David <dearrest01011@gmail.com>
Date:   Tue, 7 Nov 2023 10:50:52 -0800
X-Google-Sender-Auth: A5grz3qa3qVFicl4v2aKfxWpT8Y
Message-ID: <CAMroiSNMo2TnQcL71ZfG2T=o1A-OOWFJKMUMP7cmb1qyr6yCgg@mail.gmail.com>
Subject: Dear Friend,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear Friend,

?I know that this email will come to you as a surprise. Please, do not
worry at all. This is a lifetime opportunity and I want you to partner
with me to make it a huge success for the mutual benefit of our both
families.

My name is Mr. David, I am working with one of the prime banks in
Burkina Faso. Here in this bank existed a dormant account for many
years, which belonged to one of our late foreign customers. The amount
in this account stands at $13,300,000.00 (Thirteen Million Three
Hundred Thousand US Dollars).

?It will be in my interest to transfer this fund in an offshore
account. I am seeking your assistance as the beneficiary of this
unclaimed fund. Everything will be done conveniently and the funds
will be safely and successfully transferred into your reliable bank
account as the next of kin to the deceased.

This is a genuine, risk free and legal business transaction. Once you
indicate your interest, I will send you more details on how the
business will be executed.

If you are really sure of your sincerity, trustworthiness,
accountability and confidentiality over this transaction,

Best regards,

Mr. David
