Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8386D782D02
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjHUPOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbjHUPOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:14:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAFDF3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:14:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991c786369cso463303366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692630857; x=1693235657;
        h=reply-to:date:to:subject:content-description
         :content-transfer-encoding:mime-version:from:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aKCqaMaAVyMGguHrrRVu+UdITejBIKu+DpTcyBRKnY=;
        b=HGF32mCJLBgXB90NxT938gj69wlqWldcjbZlQor6n8KMs9dArr4tl8INGfDXSa8/e/
         aAwMjncOc1MEe0WJZvaCHD9doNH/UEKWYkTBBSNHHh0Rq7hyVWAa1PM/FdpbxQ4TkYHb
         FNAtaeL/mlxWYO57Ztvhux/9K3BoUiaHeb9m0aA9CF6xUeNHyTg+kGK4HkRO3kls1H20
         frwSRumhhK8zNiO2KYyCKFjMPnyJo8yI0ulOYZX/FwXr1tHXhl3ezxoNvRrF3zjbo/Ej
         AnHcUgYbgRPy1l3xl2mM27PT1EP1NLgmd2FJkTWoF3v8R6vjo9205+X9f2jTHLdyl6OP
         LyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692630857; x=1693235657;
        h=reply-to:date:to:subject:content-description
         :content-transfer-encoding:mime-version:from:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aKCqaMaAVyMGguHrrRVu+UdITejBIKu+DpTcyBRKnY=;
        b=gLzJSrz/offzONQKKAp+s9900oPNtPJwsfuE7A6TUNqwYPh6CfKsTZ5VQkl3IwM/3R
         Z3xGCBCnpSlXpIGF3NkKghb7C/et44N3usY97FkQgti+tHeycGQ2lkfVvqWVz/IyZHOB
         zxP83//E2BiyuoDq/MRd/0woNTwJVAsUDN4wpfoBHAsdlZDRd1g/9s/SBe2X5ypC1QmY
         0vsS8mujKiWWVW3j3Zj2gaPUKlS9dG5BZU3TIm4jTFHj5ym9Y+HnpwtFfFEvd2hoCHZn
         UNCh+J8zFszDVtfvC2U0FgcJ0OttbdAwj0sRF4Zc/3vwD9NWz7tMisNZlauKasFrtGcm
         DetA==
X-Gm-Message-State: AOJu0YyzbHaXGMFW67BfqV/dLmb/htp/H1GgQwcLl0dfdYUaTzDHsnav
        u4pd/+VBAUpH04Y/yMEUuREkrPS3M2iMvsGh
X-Google-Smtp-Source: AGHT+IHz29bZ27T6wGe+5ElmyBzwpLTs+p9tPkVK5+xHdLpD6LwKA5rW0MM9G4MeY/jJZFWSttXuig==
X-Received: by 2002:a17:906:8477:b0:993:dcca:9607 with SMTP id hx23-20020a170906847700b00993dcca9607mr5573526ejc.2.1692630856730;
        Mon, 21 Aug 2023 08:14:16 -0700 (PDT)
Received: from [192.168.1.102] ([45.155.42.26])
        by smtp.gmail.com with ESMTPSA id rp6-20020a170906d96600b0098e2eaec395sm6670036ejb.130.2023.08.21.08.14.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 21 Aug 2023 08:14:16 -0700 (PDT)
Message-ID: <64e37f48.170a0220.3fb1d.e424@mx.google.com>
From:   WORLD HEALTH ORGANIZATION EMPOWERMENT GROUP 
        <alexandercar239@gmail.com>
X-Google-Original-From: WORLD HEALTH ORGANIZATION EMPOWERMENT GROUP
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: We Have a Job in Your Country For You
To:     Recipients <WORLD@vger.kernel.org>
Date:   Mon, 21 Aug 2023 22:13:56 +0700
Reply-To: dr.masonfinley@gmail.com
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,TO_MALFORMED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings! =

We are writing this email to you from the (World Health Organization Empowe=
rment Group) to inform you that we have a job opportunity for you in your c=
ountry.

If you receive this message, send your CV to Dr. Mason Finley, via this ema=
il address, dr.masonfinley@gmail.com, for more information about the job. T=
he job cannot stop your business or the work you are already doing. =


We know that this message may come to you as a surprise.


Best Regards
Management Director
Dr. Mason Finley
Email: dr.masonfinley@gmail.com
Office WhatsApp Number: +15512773435
Office Contact Number: +447405575102

