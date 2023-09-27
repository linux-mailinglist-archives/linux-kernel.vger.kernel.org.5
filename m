Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871AD7B0260
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjI0LEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjI0LEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:04:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5FBFC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:04:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50329046cc1so3519699e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695812681; x=1696417481; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=drc6W8u2DX/10g03Ar+h3K064oPeFVxRxtnQvkd3BDuRvXGXN3zrm/JaQqcoQYXkNs
         DFdwPSCSFib5RxmXk5L1HvgNKOpbp8bqgh+4xVIbGg9H0/E+iq37fyJjPCvioRGUWThm
         l2r+oSUcMi+RgCs2b7I1mYpf5Hi+kXx+Ej+9yyZoFtXJ01sIljTB4vN9k3oFAzHyJoVh
         eqsnlILCtLochb/FTtvMEFDRngGI98Cf3sHzXouoWBa0canGn2p46SFOFDMDKkI6AXe5
         3wZio6bIG3q0PA5icj+OmdfqP7nvnNcFdGeyeJ3Oq9OlevPf2vXccpnlNJWv419hjFY9
         DWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695812681; x=1696417481;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=g+G7KSqT7OIgBtIXzqgyqJouY35652PONXx43zid1MN3GQWvgzYMlN2XR82PIKcwML
         Ros5e3kiUgJeUJs9QOrBk9e0y8nT8yj2pr0+PwkzsF64N6BGSPbntNK4x0zoqg7XrFPR
         9ZoYjKKWGRWAsOjVc1lMzVMC5z7cS+jfHuk1bJm/Fa+/DLOl3W9iQimi5JFgdl0jNVfz
         sTEnYSe2I/kHaAajjMSkUZgXUflhCv5D68tzR8W0aU9saHyfnr9yOyStDybqGx4wgVT1
         FLg2vgYwumLUDVA3kC1KbKyhstp/qdxE8akjiv9Qi1gjEbb+3+dnVdztcltNxtenuiSm
         Hlog==
X-Gm-Message-State: AOJu0YzHAudZpo0sqqPVCyF/rxCdlMi47AkedsKzJjQdgrjZuzOwPbck
        aQ3ge0UqzaoEq7HEt//fZZnD9h0mBP+JvK/m8jY=
X-Google-Smtp-Source: AGHT+IFDYUnk8ZWr2QxoVqJPsKFAGG0KQFbaPMMEizZQQ+Uqev5x2ugL/r2ayBg6eyfP/H3ZmB35W+snP3TdZrilyLo=
X-Received: by 2002:a05:6402:51c8:b0:52f:bedf:8f00 with SMTP id
 r8-20020a05640251c800b0052fbedf8f00mr1839110edd.1.1695812680620; Wed, 27 Sep
 2023 04:04:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:a58e:0:b0:235:650d:54b9 with HTTP; Wed, 27 Sep 2023
 04:04:39 -0700 (PDT)
Reply-To: philipmosakki2000@gmail.com
From:   Philip Mosakki <mop385831@gmail.com>
Date:   Wed, 27 Sep 2023 04:04:39 -0700
Message-ID: <CAPX-SZ3+-CUOqLSctqweizUKiuEnNLA+oVX8EY06b-FfuT9z-Q@mail.gmail.com>
Subject: =?UTF-8?Q?RE=3A_I=E2=80=99m_Philip_A=2E_Mosaki=2E_I_sent_a_message_to_you_?=
        =?UTF-8?Q?before=2C_but_I_did_not_hear_from_you=2C_did_you_receive_it=3F?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:133 listed in]
        [list.dnswl.org]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mop385831[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mop385831[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [philipmosakki2000[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts
        *  2.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


