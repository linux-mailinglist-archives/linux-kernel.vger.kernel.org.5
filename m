Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDC57B1F68
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjI1O0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjI1O0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:26:35 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B49F5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:26:22 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.97.250]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MCsLo-1quhcT2cAi-008oqz; Thu, 28 Sep 2023 16:23:57 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 3B84A3F714;
        Thu, 28 Sep 2023 16:23:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1695911032; bh=rrG6e3agpf2u+xdW5EebxCgAIgDQqDDDehdHU4UpuSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9VyJAHr+r6y2EtJaCNO6HBblZVQgzaUGhMwVZ6O8WP+KHQgN2FjXoRADIfysq8pF
         kJGLQ7huV6RT+PiTX1v6vTmKUB4n/gTFbtEy7TNQRVZegIIveW812XKAd9oFPz49Zh
         qFCYktXaWarLodorMHCNFp6c3VBgzUAjnYLjIA7I=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 8CBC03B5; Thu, 28 Sep 2023 16:23:21 +0200 (CEST)
Date:   Thu, 28 Sep 2023 16:23:21 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Ian Rogers <irogers@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Yuan Can <yuancan@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 01/18] gen_compile_commands: Allow the line prefix to
 still be cmd_
Message-ID: <ZRWMWcNKvZMgiAMR@bergen.fjasle.eu>
References: <20230923053515.535607-1-irogers@google.com>
 <20230923053515.535607-2-irogers@google.com>
 <CAKwvOdmHg_43z_dTZrOLGubuBBvmHdPxSFjOWa3oWkbOp2qWWg@mail.gmail.com>
 <CAP-5=fV6c1tWAd2GjMwn4PQN=3BXNQGz=vbonHSjRjQ3fbEL+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV6c1tWAd2GjMwn4PQN=3BXNQGz=vbonHSjRjQ3fbEL+g@mail.gmail.com>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:WNIhYuQMIKkE8jRY9K+NatBF6dWQ4oI0AVrEW1Ph+1/B/OQCMOe
 UYvFzVf/gYNyD6apt1zxPnOEgXzDOp9rgmnrzkCk/swgt7YBVUGMKuIlKd5Y7q2eeaVsy3G
 UFMUULZIEOZtgVKKG1vHszO/HQPrY0TZy33PsLUS/IGIcPSHB/wyyhhSJK00ACowyMnhW4R
 gzpdERsa8atFSBEFq+ebQ==
UI-OutboundReport: notjunk:1;M01:P0:4R+biovEgMA=;hfIWEyeEhHbqLwgwu4d9A7dt+KK
 uQmFLaxNc+Yas6L3Z2FLCg7yAdrFaRx25KnWVptIZe04DmeZIOy6jjmen684zHKejx44XYdo0
 HodLUlkM5DyAbULDcPCjjINGWldRQK6g2Qbd1KBXjnGu5HeDMEPpHvd4sph70pQ5qDlR0U3qs
 0NmlIklBkeVmIIUbK11B2Q7Tz+mcfFhjzyLgwlGjKLDDtyXSr8GuSFh6IsFj7N5oj6ZiUJTwU
 VcCZi2Ab+RBnYassYPZSg2J4nGpsCI8REoiVrJeuq3OGZsOoC1FtQU7z/xwCuX700U6VTA9/D
 +cVF93nNpgluNSa5J1vC5BHLFvKj+lv1qJpavuss+WRu3BPQSoazWrl5R1hy0xsmb45EEqHuk
 T7vSRBZJqsqPF6XjLvQzZjgXkEojQhGJQKO/vDJi3N1xH3Ayn4I5eATyIa1G7DaiOC4Q6MIyY
 EYsQnuhO7nKvDFO0sFhqpI8F86+cOhF2lziwmFCZ8qZ0CcNg4H3QjOPik3BH9ChkV2LPZPGSI
 J9R1k/tGFQAZzu6UMkKIF4Ari1XrW5sQ5YnKd4JSF9Q+7riPFof30JDU0N0J1h42oPfSDjgUh
 eUG72YnkgWusIZKzVqvazglh+E5eQYVw+kRj+N8iNxpHNSSlrzev4TaF1/fkWNHCO1LoBr7AL
 5OE3us3x7yWPd1uYwPu0341E13rw7JPrygCkIpkKPREiFd7c7nSTOjraWkBrqaH17lKK5AUBG
 2CyH98eigEEWX9TdUVhubiKC6qAM5q5QioH0B1hFIlUaXyjuUNvfFqg3wzSEF+FwlfO88uGh8
 TGlCznkqj0yOJhcRExmGul8+cbqUXA8nRI1sBHQe2QP0f5OI+QA0OI3gAqfXSpNjev08umbao
 mIS1hqFWKKpXaXw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 09:06:11 -0700, Ian Rogers wrote:
> On Mon, Sep 25, 2023 at 8:49 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Sep 22, 2023 at 10:35 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > Builds in tools still use the cmd_ prefix in .cmd files, so don't
> > > require the saved part. Name the groups in the line pattern match so
> >
> > Is that something that can be changed in the tools/ Makefiles?
> >
> > I'm fine with this change, just curious where the difference comes
> > from precisely.
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> I agree. The savedcmd_ change came from Masahiro in:
> https://lore.kernel.org/lkml/20221229091501.916296-1-masahiroy@kernel.org/
> I was reluctant to change the build logic in tools/ because of the
> potential to break things. Maybe Masahiro/Nicolas know of issues?

I haven't seen any issues related to the introduction of savedcmd_; and 
roughly searching through tools/ I cannot find a rule that matches the 
pattern Masahiro described in commit 92215e7a801d ("kbuild: rename 
cmd_$@ to savedcmd_$@ in *.cmd files", 2022-12-29).  For consistency, 
I'd like to see the build rules in tools/ re-use the ones from scripts/ 
but as of now I don't see any necessity to introduce savedcmd in 
tools/, yet.

Kind regards,
Nicolas
