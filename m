Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABD77E84E4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 22:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344840AbjKJVCg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Nov 2023 16:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjKJVCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 16:02:22 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE0FAE70
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:34:48 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5b7f3f47547so2089844a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699641243; x=1700246043;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1ontVIbTPsl2LZLoKY4VKd6GjVg9ZN7I6r5oEz8ngc=;
        b=DRnGieuEJHQRYh+E8Y25bNTw2Jg1939v7YuLNOAdYfGSJNbq5Ok+hEfhhdYZRSHbXI
         U2p+sHXZeqFIVZ7uDs34HLGvcdwd7VykIH1cqSbczA6ibGlk8iX5Yb7WWHpbpRwojpGc
         oiEtwSYnN/15QQdDBZMmcuPNcB/KWA54r8j6Iw+EYAmPl9zKypCCcJULZY/++oQ59oJ4
         fva1jrimP0iLYPb7ShdFiJZWWThMwuRHbtdv0jC3f/6GkP4c/F6wUk291mWV0JiGnL4G
         Zy9BO6mV6BL1JR5kHdlqGd3NVzhTDL0rYkRO23JRyETTuUjEz9Bn8p7oyn0e/+54Jc06
         ptBg==
X-Gm-Message-State: AOJu0Yzrijc0MTmZ1faaWRXhlIXdFdAZuXwgkKWTrCko+i5OSOb2K5e4
        QSjvXLbO2lrUz60nmqBOZR4adsqjd0Tu/06/BrLhKbuTsn+5TXk=
X-Google-Smtp-Source: AGHT+IFnQDIivu0oYCJJw8NrO0j546dthxDQAogk3QbU2BNDLkihx/LdITq2+Hv3RM5/kXHIeNpCboAvm1SlCBhZbP2tE2yF/gfE
MIME-Version: 1.0
X-Received: by 2002:a63:595e:0:b0:5be:297d:7932 with SMTP id
 j30-20020a63595e000000b005be297d7932mr25656pgm.0.1699641242854; Fri, 10 Nov
 2023 10:34:02 -0800 (PST)
Date:   Fri, 10 Nov 2023 10:34:02 -0800
In-Reply-To: <GV1PR10MB6563D9C05186E24A90AE343AE8AEA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086adab0609d09029@google.com>
Subject: Re: [syzbot] [usb] kernel BUG in __page_table_check_zero
From:   syzbot <syzbot+7a9bbb158a7a1071eb27@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

 T48] page_table_check: ===> fmap check_zero 0
[  362.170604][  T505] page_table_check: ===> fmap check_zero 0
[  362.170797][  T505] page_table_check: ===> anon check_zero 0
[  362.170809][  T505] page_table_check: ===> fmap check_zero 0
[  362.170818][  T505] page_table_check: ===> anon check_zero 0
[  362.170827][  T505] page_table_check: ===> fmap check_zero 0
[  362.171069][  T505] page_table_check: ===> anon check_zero 0
[  362.176794][  T504] page_table_check: ===> fmap check_zero 0
[  362.182799][    T1] page_table_check: ===> fmap check_zero 0
[  362.188866][  T504] page_table_check: ===> anon check_zero 0
[  362.201636][    T1] page_table_check: ===> anon check_zero 0
[  362.206696][  T506] page_table_check: ===> fmap check_zero 0
[  362.218333][  T505] page_table_check: ===> fmap check_zero 0
[  362.218375][  T505] page_table_check: ===> anon check_zero 0
[  362.224199][   T48] page_table_check: ===> anon check_zero 0
[  362.230061][    T1] page_table_check: ===> fmap check_zero 0
[  362.236027][   T48] page_table_check: ===> fmap check_zero 0
[  362.241852][  T505] page_table_check: ===> fmap check_zero 0
[  362.247788][  T504] page_table_check: ===> fmap check_zero 0
[  362.253929][  T136] page_table_check: ===> anon check_zero 0
[  362.259605][  T506] page_table_check: ===> anon check_zero 0
[  362.265348][  T136] page_table_check: ===> fmap check_zero 0
[  362.271393][   T48] page_table_check: ===> anon check_zero 0
[  362.277427][    T1] page_table_check: ===> anon check_zero 0
[  362.283007][  T504] page_table_check: ===> anon check_zero 0
[  362.289355][  T505] page_table_check: ===> anon check_zero 0
[  362.295354][  T506] page_table_check: ===> fmap check_zero 0
[  362.301332][  T136] page_table_check: ===> anon check_zero 0
[  362.307509][   T48] page_table_check: ===> fmap check_zero 0
[  362.313384][    T1] page_table_check: ===> fmap check_zero 0
[  362.319135][  T504] page_table_check: ===> fmap check_zero 0
[  362.319779][  T506] page_table_check: ===> anon check_zero 0
[  362.325036][  T505] page_table_check: ===> fmap check_zero 0
[  362.331050][   T48] page_table_check: ===> anon check_zero 0
[  362.336835][  T136] page_table_check: ===> fmap check_zero 0
[  362.343553][  T506] page_table_check: ===> fmap check_zero 0
[  362.349854][  T506] page_table_check: ===> anon check_zero 0
[  362.356354][  T505] page_table_check: ===> anon check_zero 0
[  362.374065][   T48] page_table_check: ===> fmap check_zero 0
[  362.374322][  T136] page_table_check: ===> anon check_zero 0
[  362.380577][    T1] page_table_check: ===> anon check_zero 0
[  362.386242][   T48] page_table_check: ===> anon check_zero 0
[  362.392397][  T507] page_table_check: ===> anon check_zero 0
[  362.404172][  T136] page_table_check: ===> fmap check_zero 0
[  362.404185][  T136] page_table_check: ===> anon check_zero 0
[  362.404193][  T136] page_table_check: ===> fmap check_zero 0
[  362.404202][  T136] page_table_check: ===> anon check_zero 0
[  362.410304][    T1] page_table_check: ===> fmap check_zero 0
[  362.416144][  T506] page_table_check: ===> fmap check_zero 0
[  362.422138][  T505] page_table_check: ===> fmap check_zero 0
[  362.428011][   T48] page_table_check: ===> fmap check_zero 0
[  362.434082][  T507] page_table_check: ===> fmap check_zero 0
[  362.440003][  T136] page_table_check: ===> fmap check_zero 0
[  362.445999][   T26] page_table_check: ===> anon check_zero 0
[  362.451679][  T506] page_table_check: ===> anon check_zero 0
[  362.457737][  T505] page_table_check: ===> anon check_zero 0
[  362.463592][   T48] page_table_check: ===> anon check_zero 0
[  362.469633][  T507] page_table_check: ===> anon check_zero 0
[  362.475448][  T506] page_table_check: ===> fmap check_zero 0
[  362.481510][   T26] page_table_check: ===> fmap check_zero 0
[  362.487421][  T136] page_table_check: ===> anon check_zero 0
[  362.493500][  T505] page_table_check: ===> fmap check_zero 0
[  362.499315][   T48] page_table_check: ===> fmap check_zero 0
[  362.505100][   T26] page_table_check: ===> anon check_zero 0
[  362.510969][  T506] page_table_check: ===> anon check_zero 0
[  362.516841][  T507] page_table_check: ===> fmap check_zero 0
[  362.522638][  T136] page_table_check: ===> fmap check_zero 0
[  362.528771][   T26] page_table_check: ===> fmap check_zero 0
[  362.540632][   T48] page_table_check: ===> anon check_zero 0
[  362.540658][   T48] page_table_check: ===> fmap check_zero 0
[  362.546730][  T507] page_table_check: ===> anon check_zero 0
[  362.558342][  T506] page_table_check: ===> fmap check_zero 0
[  362.564168][   T26] page_table_check: ===> anon check_zero 0
[  362.570010][  T136] page_table_check: ===> anon check_zero 0
[  362.581609][   T26] page_table_check: ===> fmap check_zero 0
[  362.581624][   T26] page_table_check: ===> anon check_zero 0
[  362.581633][   T26] page_table_check: ===> fmap check_zero 0
[  362.581641][   T26] page_table_check: ===> anon check_zero 0
[  362.587428][   T48] page_table_check: ===> anon check_zero 0
[  362.593394][  T507] page_table_check: ===> fmap check_zero 0
[  362.599226][  T506] page_table_check: ===> anon check_zero 0
[  362.604935][  T507] page_table_check: ===> anon check_zero 0
[  362.610759][  T136] page_table_check: ===> fmap check_zero 0
[  362.610770][  T136] page_table_check: ===> anon check_zero 0
[  362.610778][  T136] page_table_check: ===> fmap check_zero 0
[  362.611101][   T48] page_table_check: ===> fmap check_zero 0
[  362.622499][   T26] page_table_check: ===> fmap check_zero 0
[  362.622518][   T26] page_table_check: ===> anon check_zero 0
[  362.622527][   T26] page_table_check: ===> fmap check_zero 0
[  362.622536][   T26] page_table_check: ===> anon check_zero 0
[  362.622544][   T26] page_table_check: ===> fmap check_zero 0
[  362.622553][   T26] page_table_check: ===> anon check_zero 0
[  362.622561][   T26] page_table_check: ===> fmap check_zero 0
[  362.622974][    T1] page_table_check: ===> anon check_zero 0
[  362.629089][  T508] page_table_check: ===> anon check_zero 0
[  362.634902][  T507] page_table_check: ===> fmap check_zero 0
[  362.641106][  T506] page_table_check: ===> fmap check_zero 0
[  362.647132][    T1] page_table_check: ===> fmap check_zero 0
[  362.653063][  T508] page_table_check: ===> fmap check_zero 0
[  362.653224][  T508] page_table_check: ===> anon check_zero 0
[  362.659026][  T507] page_table_check: ===> anon check_zero 0
[  362.665107][   T48] page_table_check: ===> anon check_zero 0
[  362.670977][    T1] page_table_check: ===> anon check_zero 0
[  362.676923][  T508] page_table_check: ===> fmap check_zero 0
[  362.683091][  T507] page_table_check: ===> fmap check_zero 0
[  362.689007][   T48] page_table_check: ===> fmap check_zero 0
[  362.694822][    T1] page_table_check: ===> fmap check_zero 0
[  362.700692][  T508] page_table_check: ===> anon check_zero 0
[  362.706504][    T1] page_table_check: ===> anon check_zero 0
[  362.712313][   T48] page_table_check: ===> anon check_zero 0
[  362.718102][  T507] page_table_check: ===> anon check_zero 0
[  362.724005][  T508] page_table_check: ===> fmap check_zero 0
[  362.724084][  T508] page_table_check: ===> anon check_zero 0
[  362.730443][    T1] page_table_check: ===> fmap check_zero 0
[  362.742125][   T48] page_table_check: ===> fmap check_zero 0
[  362.742140][   T48] page_table_check: ===> anon check_zero 0
[  362.742149][   T48] page_table_check: ===> fmap check_zero 0
[  362.747966][  T507] page_table_check: ===> fmap check_zero 0
[  362.754060][  T508] page_table_check: ===> fmap check_zero 0
[  362.760256][  T507] page_table_check: ===> anon check_zero 0
[  362.766035][  T508] page_table_check: ===> anon check_zero 0
[  362.771928][    T1] page_table_check: ===> anon check_zero 0
[  362.789904][   T48] page_table_check: ===> anon check_zero 0
[  362.795796][  T507] page_table_check: ===> fmap check_zero 0
[  362.801593][  T508] page_table_check: ===> fmap check_zero 0
[  362.807727][    T1] page_table_check: ===> fmap check_zero 0
[  362.813956][   T48] page_table_check: ===> fmap check_zero 0
[  362.814626][  T508] page_table_check: ===> anon check_zero 0
[  362.820477][  T507] page_table_check: ===> anon check_zero 0
[  362.826233][  T508] page_table_check: ===> fmap check_zero 0
[  362.832257][  T509] page_table_check: ===> anon check_zero 0
[  362.838122][  T508] page_table_check: ===> anon check_zero 0
[  362.844115][    T1] page_table_check: ===> anon check_zero 0
[  362.849969][  T508] page_table_check: ===> fmap check_zero 0
[  362.855798][  T509] page_table_check: ===> fmap check_zero 0
[  362.861974][  T508] page_table_check: ===> anon check_zero 0
[  362.867839][  T507] page_table_check: ===> fmap check_zero 0
[  362.873941][  T508] page_table_check: ===> fmap check_zero 0
[  362.873974][  T508] page_table_check: ===> anon check_zero 0
[  362.879897][    T1] page_table_check: ===> fmap check_zero 0
[  362.885647][  T508] page_table_check: ===> fmap check_zero 0
[  362.891568][  T509] page_table_check: ===> anon check_zero 0
[  362.897508][  T508] page_table_check: ===> anon check_zero 0
[  362.903417][    T1] page_table_check: ===> anon check_zero 0
[  362.909588][  T507] page_table_check: ===> anon check_zero 0
[  362.915670][  T509] page_table_check: ===> fmap check_zero 0
[  362.922010][  T508] page_table_check: ===> fmap check_zero 0
[  362.922268][  T507] page_table_check: ===> fmap check_zero 0
[  362.928273][    T1] page_table_check: ===> fmap check_zero 0
[  362.946173][  T507] page_table_check: ===> anon check_zero 0
[  362.951968][  T509] page_table_check: ===> anon check_zero 0
[  362.957659][  T507] page_table_check: ===> fmap check_zero 0
[  362.963596][  T509] page_table_check: ===> fmap check_zero 0
[  362.969542][  T507] page_table_check: ===> anon check_zero 0
[  362.975535][    T1] page_table_check: ===> anon check_zero 0
[  362.981655][  T507] page_table_check: ===> fmap check_zero 0
[  362.981703][  T507] page_table_check: ===> anon check_zero 0
[  362.987766][  T509] page_table_check: ===> anon check_zero 0
[  362.993978][  T507] page_table_check: ===> fmap check_zero 0
[  363.000193][  T509] page_table_check: ===> fmap check_zero 0
[  363.006135][    T1] page_table_check: ===> fmap check_zero 0
[  363.012006][  T509] page_table_check: ===> anon check_zero 0
[  363.017866][  T507] page_table_check: ===> anon check_zero 0
[  363.023838][  T509] page_table_check: ===> fmap check_zero 0
[  363.029621][    T1] page_table_check: ===> anon check_zero 0
[  363.035479][  T509] page_table_check: ===> anon check_zero 0
[  363.041486][  T507] page_table_check: ===> fmap check_zero 0
[  363.041576][  T507] page_table_check: ===> anon check_zero 0
[  363.047346][  T509] page_table_check: ===> fmap check_zero 0
[  363.053325][    T1] page_table_check: ===> fmap check_zero 0
[  363.059270][  T509] page_table_check: ===> anon check_zero 0
[  363.070877][  T507] page_table_check: ===> fmap check_zero 0
[  363.071265][  T507] page_table_check: ===> anon check_zero 0
[  363.076930][  T509] page_table_check: ===> fmap check_zero 0
[  363.100683][  T507] page_table_check: ===> fmap check_zero 0
[  363.100729][  T507] page_table_check: ===> anon check_zero 0
[  363.106822][    T1] page_table_check: ===> anon check_zero 0
[  363.112756][  T510] page_table_check: ===> anon check_zero 0
[  363.118393][    T1] page_table_check: ===> fmap check_zero 0
[  363.124401][  T507] page_table_check: ===> fmap check_zero 0
[  363.130450][  T509] page_table_check: ===> anon check_zero 0
[  363.136428][  T510] page_table_check: ===> fmap check_zero 0
[  363.142284][    T1] page_table_check: ===> anon check_zero 0
[  363.142295][    T1] page_table_check: ===> fmap check_zero 0
[  363.148284][  T507] page_table_check: ===> anon check_zero 0
[  363.154130][  T509] page_table_check: ===> fmap check_zero 0
[  363.160012][  T510] page_table_check: ===> anon check_zero 0
[  363.165742][    T1] page_table_check: ===> anon check_zero 0
[  363.171650][  T507] page_table_check: ===> fmap check_zero 0
[  363.177554][  T509] page_table_check: ===> anon check_zero 0
[  363.183343][  T510] page_table_check: ===> fmap check_zero 0
[  363.183392][  T510] page_table_check: ===> anon check_zero 0
[  363.189568][    T1] page_table_check: ===> fmap check_zero 0
[  363.195613][  T507] page_table_check: ===> anon check_zero 0
[  363.201594][  T509] page_table_check: ===> fmap check_zero 0
[  363.207478][  T510] page_table_check: ===> fmap check_zero 0
[  363.213522][    T1] page_table_check: ===> anon check_zero 0
[  363.231108][  T507] page_table_check: ===> fmap check_zero 0
[  363.231194][  T507] page_table_check: ===> anon check_zero 0
[  363.237079][  T509] page_table_check: ===> anon check_zero 0
[  363.242929][  T510] page_table_check: ===> anon check_zero 0
[  363.248848][  T509] page_table_check: ===> fmap check_zero 0
[  363.254710][  T510] page_table_check: ===> fmap check_zero 0
[  363.272200][    T1] page_table_check: ===> fmap check_zero 0
[  363.273342][    T1] page_table_check: ===> anon check_zero 0
[  363.278222][  T507] page_table_check: =

syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs-2/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs-2/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.20.1"
GCCGO="gccgo"
GOAMD64="v1"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.mod"
GOWORK=""
CGO_CFLAGS="-O2 -g"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-O2 -g"
CGO_FFLAGS="-O2 -g"
CGO_LDFLAGS="-O2 -g"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build1863032191=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 65faba364
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=65faba36470e75a1339e6f79c8631c9578786b7b -X 'github.com/google/syzkaller/prog.gitRevisionDate=20231002-164030'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=65faba36470e75a1339e6f79c8631c9578786b7b -X 'github.com/google/syzkaller/prog.gitRevisionDate=20231002-164030'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=65faba36470e75a1339e6f79c8631c9578786b7b -X 'github.com/google/syzkaller/prog.gitRevisionDate=20231002-164030'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"65faba36470e75a1339e6f79c8631c9578786b7b\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=16dc951f680000


Tested on:

commit:         89cdf9d5 Merge tag 'net-6.7-rc1' of git://git.kernel.o..
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=97c84b399d02b00b
dashboard link: https://syzkaller.appspot.com/bug?extid=7a9bbb158a7a1071eb27
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1313b4b7680000

