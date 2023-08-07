Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10CB77303B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjHGUUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjHGUUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:20:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BC410D8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:20:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3797362158
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAC9C433C7;
        Mon,  7 Aug 2023 20:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691439648;
        bh=t+0Rs/9WbAf74pByl+sVcwT7tuChF8GXYp/rZGjtmwE=;
        h=From:To:Cc:Subject:Date:From;
        b=jGNzBM5hDNV0joVAm2LTpfPwra6FoTDnzY/9e5sJVHjnGD4+TT5JLhC78yXZ4AdBZ
         jdXc85WO+N5/DHYSXKKYb/UWt2pwI5+E1sSDChkYya3BCzdtJM87Dbbjk7lzNkhmDV
         ydw/+Kpj5dA/xF41sAfaljAs/5vSPsByM9LxkUGuB6tGklE9kh4uuSChTC7EyrbVV0
         tHtNPMV+zTamgr7EZuOdmBWFZ6STfsCfOlsfcN7ghAQJ2jm/VSd0JtVlGEUWgQvLJA
         1P4dHZQPkK16hb+b/hSvXXpHmHaRnGLtdUJYooDTPU3ggRZXTHrMsEwQUrJNdsC108
         uHM4jsX8zlP7w==
From:   SeongJae Park <sj@kernel.org>
To:     damon@lists.linux.dev
Cc:     Andrew Paniakin <apanyaki@amazon.com>,
        Dongjoo Seo <commisori28@gmail.com>,
        fdu <1050329+fdu@users.noreply.github.com>,
        Honggyu Kim <honggyu.kp@gmail.com>,
        Michel Alexandre Salim <salimma@fedoraproject.org>,
        Puranjay Mohan <pjy@amazon.de>,
        Steve Scargall <steve.scargall@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: DAMON user-space tool (damo) has reached its 100th release
Date:   Mon,  7 Aug 2023 20:20:44 +0000
Message-Id: <20230807202044.98700-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello DAMON community,


DAMON user-space tool (damo)[1] has started as a simple wrapper of commands,
and I personally didn't consider it serious, compared to DAMON.  However, the
community started to give it interests and helps.  Thanks to the helps, it has
now evolved a lot.  Currently, I consider it as an important part of DAMON
project, and try to spend enough time for the tool, sometimes even more than
DAMON.  That's a part of reasons why I started talks about the tool at
conferences[2,3].

We made the first release of it nearly two years ago, at 2021-08-30.  Since
then, we tried to continue its development and release a new version about once
per week.  According to the log, we missed the goal sometimes, but successfully
continued the overall pace.

As a result, we made 2,614 commits since the first release, and just tagged and
pushed the last commit as its 100th release[4].  It's just a trivial
achievement compared to other serious projects, but makes a humble hacker like
me a little emotional.  It was possible all thanks to the community.  It's
actually the community's achievement.  I therefore just wanted to share this
small achievement to ourselves, and say thank you for your helps once again.

The community's helps include both code and non-code.  I'd like to appreciate
samely, but I don't have a script for fetching name of all.  Please forgive my
tiny brain.  I'd like to list contributors who I can fetch the name here.  Huge
thanks again.

    $ git log --pretty="%an <%ae>" | sort | uniq
    Andrew Paniakin <apanyaki@amazon.com>
    Dongjoo Seo <commisori28@gmail.com>
    fdu <1050329+fdu@users.noreply.github.com>
    Honggyu Kim <honggyu.kp@gmail.com>
    Michel Alexandre Salim <salimma@fedoraproject.org>
    [...] # Hiding one having an incorrect email.
    Puranjay Mohan <pjy@amazon.de>
    [...] # Hiding myself.
    Steve Scargall <steve.scargall@intel.com>

Also sharing some trivial statistics about the release.  The stat has counted
using a buggy script[5].  In average, we made 3,417 lines of diff for each
release.  Also attaching the full output of the script below.

    $ ../relstat/relstat.py --versions $(git tag)
                   version      files  deletions insertions       diff
        v0.0.2(2021-09-06)         13         73         95        168
        v0.0.3(2021-09-13)          7        103        118        221
        [...]
        v1.9.3(2023-08-07)          8        140        381        521
                     # avg         12       1669       1748       3417
                     # min          0          0          0          0
                     # max         89     112950     112950     225900
                   # total       1211     168576     176573     345149
    # Among the 101 releases, v1.9.3 has
    #    47th smallest file changes
    #    84th smallest insertions
    #    66th smallest deletions
    #    80th smallest diffs

Looking forward to 200th, and 1,000th release of damo :D  We, the community,
will make it together.

[1] https://github.com/awslabs/damo
[2] https://sched.co/1K5HS
[3] https://sched.co/1OGf9
[4] https://github.com/awslabs/damo/releases/tag/v1.9.3
[5] https://github.com/sjp38/relstat


Thanks,
SJ

----

$ ../relstat/relstat.py --versions $(git tag)
               version      files  deletions insertions       diff
    v0.0.2(2021-09-06)         13         73         95        168
    v0.0.3(2021-09-13)          7        103        118        221
    v0.0.4(2021-09-22)          4          4         31         35
    v0.0.5(2021-09-28)          5         15         14         29
    v0.0.7(2021-10-12)          4         42         42         84
    v0.0.8(2021-10-19)          2          2          7          9
    v0.0.9(2021-10-20)          0          0          0          0
    v1.0.0(2021-11-02)          0          0          0          0
    v1.0.1(2021-11-09)          2          4          4          8
    v1.0.2(2021-11-16)         14          6         24         30
    v1.0.3(2021-11-23)          8         10        142        152
    v1.0.4(2021-11-26)          2          2          2          4
    v1.0.5(2021-11-30)          2          3          3          6
    v1.0.6(2021-12-07)          7         14         31         45
    v1.0.7(2021-12-14)          2          4          8         12
    v1.0.8(2021-12-15)          2          2          2          4
    v1.0.9(2021-12-21)          0          0          0          0
    v1.1.0(2021-12-28)          7         15         90        105
    v1.1.1(2021-12-28)          3          6         19         25
    v1.1.2(2021-12-28)          4          4         51         55
    v1.1.3(2022-01-03)          3          5         11         16
    v1.1.4(2022-01-10)          4         36         17         53
    v1.1.5(2022-01-17)          4          5         34         39
    v1.1.6(2022-01-24)          5         14         21         35
    v1.1.7(2022-01-31)          4         10         29         39
    v1.1.8(2022-02-07)          2         10         12         22
    v1.1.9(2022-02-14)          7        246        450        696
    v1.2.0(2022-02-22)         13         53        248        301
    v1.2.1(2022-03-01)         12         53        172        225
    v1.2.2(2022-03-01)          3          6          3          9
    v1.2.3(2022-03-08)         10         82        283        365
    v1.2.4(2022-03-15)          3          2          3          5
    v1.2.5(2022-03-22)          8         35         57         92
    v1.2.6(2022-03-28)         23         94         79        173
    v1.2.7(2022-04-04)         10         21         31         52
    v1.2.8(2022-04-11)          7      21911      21915      43826
    v1.2.9(2022-04-26)         18      21963      23272      45235
    v1.3.0(2022-05-02)          9         30        243        273
    v1.3.1(2022-05-09)          5         13         68         81
    v1.3.2(2022-05-24)          5         33         38         71
    v1.3.3(2022-05-30)          4          3        134        137
    v1.3.4(2022-06-13)         11         26        238        264
    v1.3.5(2022-06-20)          6        106         58        164
    v1.3.6(2022-06-27)          4         32        122        154
    v1.3.7(2022-07-04)          4         37         70        107
    v1.3.8(2022-07-11)         10        368        219        587
    v1.3.9(2022-07-18)          6        195        166        361
    v1.4.0(2022-07-26)          4          5          5         10
    v1.4.1(2022-08-15)          6          5         73         78
    v1.4.2(2022-08-22)         16         82        100        182
    v1.4.3(2022-08-29)         10        134        125        259
    v1.4.4(2022-09-05)          7        165        211        376
    v1.4.5(2022-09-05)          2          2          2          4
    v1.4.6(2022-09-12)          3         75         91        166
    v1.4.7(2022-09-19)          3         55        117        172
    v1.4.8(2022-09-26)          4        186        158        344
    v1.4.9(2022-10-03)          5        163        197        360
    v1.5.0(2022-10-10)         10         66        213        279
    v1.5.1(2022-10-18)          9        118        145        263
    v1.5.2(2022-10-24)         10         40        454        494
    v1.5.3(2022-11-01)         20        214        594        808
    v1.5.4(2022-11-10)         14        110        517        627
    v1.5.5(2022-11-16)         17        537        601       1138
    v1.5.6(2022-11-21)         15        529        552       1081
    v1.5.7(2022-11-28)         75        285        773       1058
    v1.5.8(2022-12-05)         14        211        382        593
    v1.5.9(2022-12-12)          9        123        314        437
    v1.6.0(2022-12-26)         22        956       1010       1966
    v1.6.1(2023-01-03)         18        144        450        594
    v1.6.2(2023-01-09)          9        157        239        396
    v1.6.3(2023-01-16)         33        257        457        714
    v1.6.4(2023-01-23)         20        195        294        489
    v1.6.5(2023-01-30)         24        253        251        504
    v1.6.6(2023-02-10)         24        138        120        258
    v1.6.7(2023-02-13)         89        351        240        591
    v1.6.8(2023-02-20)         10        209        143        352
    v1.6.9(2023-02-27)         25        398        345        743
    v1.7.0(2023-03-06)         12        136        204        340
    v1.7.1(2023-03-13)          9        153        211        364
    v1.7.2(2023-03-20)          8         60        121        181
    v1.7.3(2023-03-20)         10         90        134        224
    v1.7.4(2023-03-27)         17        139        142        281
    v1.7.5(2023-04-03)         20        264        256        520
    v1.7.6(2023-04-10)         21         53        315        368
    v1.7.7(2023-04-17)         21        315        381        696
    v1.7.8(2023-04-24)         21        253        238        491
    v1.7.9(2023-05-01)         17     112950     112950     225900
    v1.8.0(2023-05-09)          2          0          2          2
    v1.8.1(2023-05-15)         15         67        136        203
    v1.8.2(2023-05-22)         46        325        435        760
    v1.8.3(2023-05-29)         16        231        232        463
    v1.8.4(2023-06-05)         22        362        383        745
    v1.8.5(2023-06-12)         14         89        371        460
    v1.8.6(2023-06-19)         14        171        187        358
    v1.8.7(2023-06-26)         15        174        236        410
    v1.8.8(2023-07-03)         13         43        236        279
    v1.8.9(2023-07-10)         33        189        362        551
    v1.9.0(2023-07-17)         16        178        228        406
    v1.9.1(2023-07-24)         16        286        394        680
    v1.9.2(2023-08-01)         10         47        189        236
    v1.9.3(2023-08-07)          8        140        381        521
                 # avg         12       1669       1748       3417
                 # min          0          0          0          0
                 # max         89     112950     112950     225900
               # total       1211     168576     176573     345149
# Among the 101 releases, v1.9.3 has
#    47th smallest file changes
#    84th smallest insertions
#    66th smallest deletions
#    80th smallest diffs
