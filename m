Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A034D8067E5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376934AbjLFHCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLFHCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:02:40 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7321A2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:02:46 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d045097b4cso31219285ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 23:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701846166; x=1702450966; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fu+2zCulSKmRYIMjAz25mOHD/VLglGiacC9LPzc0jW8=;
        b=LQqpKlGZ2nj0z/klZd8QA+itG40Eh/Rj0ftok6dhRTbQDS4cKg8UPdFaIrEh1UzfcL
         BWxU6Y4jDuum23mWltVMMACbAPRGQCUmetoctflXmZCV/XcZxjKf51i/F3Joan5obhrz
         8YJ94eYKbJOgdUvDtYsYnXOG0cHVh7XdqTMEZ0nXHoKCOPPaQgSPXfK3GM/DRWrKO9AP
         TdNJtcApim8K9yyrWsJsCDL3ElizdCD1Km2P7DimionnHzKVAViIo78gSKn4p1F0Pe6/
         eMKFsZprtOZqvLYVeSASOsZjIuXrX+oWMr+RoF/x9g7JBYiSyTLO7oJfRKw8/1O+uQ+N
         Dzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701846166; x=1702450966;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fu+2zCulSKmRYIMjAz25mOHD/VLglGiacC9LPzc0jW8=;
        b=s4SvTDl6oOd3udgF2XpqzFMN62jfwMyDR7rCgQiW4dqETK/sGf2Xz8dVL5rSKRA9JT
         qTWyewGlbgi+PMX4pGzSY/37fwEoR0kaMz1SV6dfKpELt4TqIH6BpFHma4dHvdfsIy/j
         X/Md1DVUEE4nVYFOVc53/z5JxGcYJrPJuepJlutWYNLGL1RJLfQ1HRV4mpHAGqg6/efV
         ZME9bQGZ6T431HJ/GzYFeSB11Cm1gDPuuG5KDBhHapXr00Y5jmwKC9IDP29hv7sZCn1s
         XkX88nzZMuuxd2FgscPXSckhCX7t7Li637zvcOBhzu1fIAjYKdNKW8X8wYcyHQZ0HMU4
         iBdA==
X-Gm-Message-State: AOJu0YyzboqwAXdiRx2J8uLlzZ6QMR9ucccRNrUeGXYZSmms3HGxKSIl
        A111IcxsVF7eIeF1yfmyQhqP0A==
X-Google-Smtp-Source: AGHT+IFutllwNx0W5P2v7t+uVkRlQHqsiAuymkq135vI7dgBN2unDgIUr+uxElxPzn8LDzhuHQ4wTg==
X-Received: by 2002:a17:902:e5c5:b0:1d0:6ffd:cea3 with SMTP id u5-20020a170902e5c500b001d06ffdcea3mr223805plf.92.1701846165671;
        Tue, 05 Dec 2023 23:02:45 -0800 (PST)
Received: from ?IPv6:2402:7500:4d5:3caa:a552:1ac3:8952:64cd? ([2402:7500:4d5:3caa:a552:1ac3:8952:64cd])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902dad200b001d0c37a9cdesm2591565plx.38.2023.12.05.23.02.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2023 23:02:45 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v3 00/12] RISC-V: provide some accelerated cryptography
 implementations using vector extensions
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231206004656.GC1118@sol.localdomain>
Date:   Wed, 6 Dec 2023 15:02:40 +0800
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        conor@kernel.org, heiko@sntech.de, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <434A2696-7C9E-4D13-9BEE-25104D37E423@sifive.com>
References: <20231205092801.1335-1-jerry.shih@sifive.com>
 <20231206004656.GC1118@sol.localdomain>
To:     Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 6, 2023, at 08:46, Eric Biggers <ebiggers@kernel.org> wrote:
> On Tue, Dec 05, 2023 at 05:27:49PM +0800, Jerry Shih wrote:
>> This series depend on:
>> 2. support kernel-mode vector
>> Link: =
https://lore.kernel.org/all/20230721112855.1006-1-andy.chiu@sifive.com/
>> 3. vector crypto extensions detection
>> Link: =
https://lore.kernel.org/lkml/20231017131456.2053396-1-cleger@rivosinc.com/=

>=20
> What's the status of getting these prerequisites merged?
>=20
> - Eric

The latest extension detection patch version is v5.
Link: =
https://lore.kernel.org/lkml/20231114141256.126749-1-cleger@rivosinc.com/
It's still under reviewing.
But I think the checking codes used in this crypto patch series will not =
change.
We could just wait and rebase when it's merged.

The latest kernel-mode vector patch version is v3.
Link: =
https://lore.kernel.org/all/20231019154552.23351-1-andy.chiu@sifive.com/
This patch doesn't work with qemu(hit kernel panic when using vector). =
It's not
clear for the status. Could we still do the reviewing process for the =
gluing code and
the crypto asm parts?

-Jerry=
