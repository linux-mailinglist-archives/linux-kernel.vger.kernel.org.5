Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84A281243F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 02:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjLNBDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 20:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjLNBDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 20:03:35 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB40D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:03:41 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50beed2a46eso1852e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702515820; x=1703120620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sdBObce72koQcJT4SQix2uzV1TxjUajOVlIUV8GBiY=;
        b=mC0kRTr6FtM3y8Y/RFA+XkAUNK7IsKb0TlrGNr9fPySorV5gLfDT2wxhG5WpkjjPw+
         EJLfrmCXzMVbVypfERO6Y4UfSbkKmXwr4KlDm2TB77ikkPSIy9Bk3Om/3h5xS8GVg0Je
         GJMLg/D/ORbSMc1Bma9ZHJu3niOMdyIXwQKlhrTeTOZfcUK6ogOJv+R1Vyii0VPWxQ32
         Z/K9FqlRmBgAIc9Ao2Md49FtUDGM1mnEpuopIAHIWMnTAfX+mCshyyMdFPcDwadF3iTu
         CaR7oh0uddfaaewcNFo8WciAjuEZQxUnPkmBpUrK5HzDWwD+QAWhnSq5Q8amAxEZoGh1
         eMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702515820; x=1703120620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sdBObce72koQcJT4SQix2uzV1TxjUajOVlIUV8GBiY=;
        b=vIgy7bnVYbHa3hwKb5PueO5/aT2Zx0+ZM7f0iguKrhM4GOlq1pWdQ09jB3HtdAspF8
         6mBcS3IzB3460lQUmd+tnKMX0SmZS0atiVOHWBuhVQPzPsGXx/w390w7rdat0fGDvSFf
         6ndNhg5j66AIKepjKFNwZ2Zk/ctkNwyb1cbvPjjZ4N5sCfgFeLTzdB9FEy+Zqr3pCC8V
         na0V/P7tdZuBkSS4ZZppbVA5AoRZoM1HaRGSNDK7UTWiD6Nl72QedsWptuHc9bRmCl42
         aTAOyhpdB72e1fSVl4QoVpvARDbxVAqAeIXs4iFQONvL1ud4yeZyjEOLbfu3+J77OymE
         kg+A==
X-Gm-Message-State: AOJu0YxqpNQdiqqA3Sn3JiqWJQ26IrhEmXNPkCK1OYPnEmHltXJuqVmK
        D0rlcsGb4hqV+xQbeYUMBZZVYtbkBvH8k1tnRPSX
X-Google-Smtp-Source: AGHT+IFcDJXYsJ4BaB+MTqyOGGuMUMJJQSIjvN4uEPvRRLbsUHFZWxmEo2Mv4Jbp9nY5aeCkwp9iF9AaQkUYOqWNltc=
X-Received: by 2002:a05:6512:4024:b0:50d:1b85:a746 with SMTP id
 br36-20020a056512402400b0050d1b85a746mr348761lfb.1.1702515819888; Wed, 13 Dec
 2023 17:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com> <c6787831-f659-12cb-4954-fd13a05ed590@amd.com>
 <CANDhNCqZdCqvWzJScKRSb+bSTYjUM7Es2ms=REiDwG8ZU8z1Yg@mail.gmail.com>
In-Reply-To: <CANDhNCqZdCqvWzJScKRSb+bSTYjUM7Es2ms=REiDwG8ZU8z1Yg@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 13 Dec 2023 17:03:28 -0800
Message-ID: <CANDhNCrJxDXt85M73saUez3w76kv6F7hWX1qG3e837j_qiRZ2Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/20] Proxy Execution: A generalized form of Priority
 Inheritance v6
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
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

On Wed, Dec 13, 2023 at 5:00=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
> I'm stewing on an idea for some sort of mutex holder (similar to a

On re-reading this, I realized holder is far too overloaded a term in
this context.

"mutex container" might be a better term for the idea.

thanks
-john
