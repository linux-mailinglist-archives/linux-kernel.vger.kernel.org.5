Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330877E81E0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbjKJShy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Nov 2023 13:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346449AbjKJSg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:36:28 -0500
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FC174F49
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 09:52:06 -0800 (PST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-280740f54b9so2235461a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 09:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699638667; x=1700243467;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Afgro0Ll18HjNnlK+5zs598lch+AuzehgECwE07Dn0Y=;
        b=Z4dWVQbXRpyLrN8H1gWX0LKLf766sCqaq51wY9aWiISw+9Kt7U6sgKE+X/RWSFC2F4
         fO5/9vy8g92AmBmPZBtKtJGZDA5OakhphjBSgf8ybpIDj0X1NRWZ1J+F/0uXFmS7B0/Y
         TlgA6/kC0PvU5eoduPhYDHSpy7n8ZQzHjvpFDA73bNA1FjEFujM05sYFTsBKxgPhgEyg
         hCCFMhHWjo9pJ5iApKo2pARGISmIRFauDb+TdGsO3ZWIrSCkSMvpudDbVV9YJVrh70ED
         jN2n0XbZLJGBPrUgtyevTR20Bs/AgfOObYeaHeK0YGth7nLXSSZdhoH+kp7olYg9grZW
         pCTQ==
X-Gm-Message-State: AOJu0Yyt6B8vYDts3T53AX2SqTGhWl0phZ6tMUjkBLatOrqTlCNPkFeo
        yxWgYm77w2E9Z1nG1ed0KXhY41b5KEc3RrGhdVCnRpE1fgt2+yo=
X-Google-Smtp-Source: AGHT+IHtZqvEsGBhoQJwuGcC1cnr4efLPM/YoqDAL1gJM6PbypFdQJ7/nbCLac+gdlE+X6ld6F93TDDmbDD9dZofqrqn5aC1sNAG
MIME-Version: 1.0
X-Received: by 2002:a17:90a:bb0f:b0:27d:15e2:b248 with SMTP id
 u15-20020a17090abb0f00b0027d15e2b248mr1402204pjr.8.1699638667253; Fri, 10 Nov
 2023 09:51:07 -0800 (PST)
Date:   Fri, 10 Nov 2023 09:51:07 -0800
In-Reply-To: <GV1PR10MB6563F922C09444C8FEAF0C58E8AEA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000021e770609cff713@google.com>
Subject: Re: [syzbot] [usb] kernel BUG in __page_table_check_zero
From:   syzbot <syzbot+7a9bbb158a7a1071eb27@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

1] ==> offset = 64
[  364.855950][    T1] ==> offset = 64
[  364.855957][    T1] ==> offset = 64
[  364.855964][    T1] ==> offset = 64
[  364.855971][    T1] ==> offset = 64
[  364.855977][    T1] ==> offset = 64
[  364.862400][  T443] ==> offset = 8
[  364.866293][  T442] ==> offset = 8
[  364.869843][  T444] ==> offset = 8
[  364.873354][  T442] ==> offset = 64
[  364.877097][  T444] ==> offset = 64
[  364.880751][    T1] ==> offset = 64
[  364.884405][  T444] ==> offset = 64
[  364.888042][  T442] ==> offset = 8
[  364.891590][  T441] ==> offset = 64
[  364.895736][  T445] ==> offset = 8
[  364.898760][  T443] ==> offset = 64
[  364.902366][  T445] ==> offset = 8
[  364.902376][  T445] ==> offset = 8
[  364.906287][  T441] ==> offset = 64
[  364.906297][  T441] ==> offset = 64
[  364.906304][  T441] ==> offset = 64
[  364.910245][    T1] ==> offset = 8
[  364.913561][  T443] ==> offset = 8
[  364.917511][  T442] ==> offset = 64
[  364.920919][  T444] ==> offset = 64
[  364.924655][    T1] ==> offset = 8
[  364.924665][    T1] ==> offset = 8
[  364.928277][  T441] ==> offset = 8
[  364.931711][    T1] ==> offset = 8
[  364.935452][  T444] ==> offset = 64
[  364.938998][  T442] ==> offset = 8
[  364.942545][  T444] ==> offset = 8
[  364.946148][  T445] ==> offset = 8
[  364.949696][  T443] ==> offset = 64
[  364.953202][  T445] ==> offset = 8
[  364.956788][  T441] ==> offset = 64
[  364.960386][  T442] ==> offset = 64
[  364.964126][  T441] ==> offset = 8
[  364.967639][    T1] ==> offset = 64
[  364.971307][  T443] ==> offset = 8
[  364.975463][  T442] ==> offset = 8
[  364.979123][  T444] ==> offset = 64
[  364.982627][  T442] ==> offset = 64
[  364.986278][  T443] ==> offset = 64
[  364.986545][  T441] ==> offset = 64
[  364.990842][  T445] ==> offset = 8
[  364.994503][  T441] ==> offset = 8
[  365.005347][    T1] ==> offset = 64
[  365.005360][    T1] ==> offset = 64
[  365.005367][    T1] ==> offset = 64
[  365.005382][    T1] ==> offset = 8
[  365.009060][  T444] ==> offset = 8
[  365.012506][    T1] ==> offset = 8
[  365.026928][  T444] ==> offset = 64
[  365.027042][  T444] ==> offset = 8
[  365.030865][  T445] ==> offset = 8
[  365.034275][  T444] ==> offset = 64
[  365.037923][  T445] ==> offset = 8
[  365.037940][  T445] ==> offset = 64
[  365.037948][  T445] ==> offset = 64
[  365.037954][  T445] ==> offset = 64
[  365.037962][  T445] ==> offset = 64
[  365.041993][  T441] ==> offset = 64
[  365.045554][  T445] ==> offset = 64
[  365.045564][  T445] ==> offset = 64
[  365.045571][  T445] ==> offset = 64
[  365.045577][  T445] ==> offset = 64
[  365.045628][  T445] ==> offset = 8
[  365.045638][  T445] ==> offset = 64
[  365.045770][  T445] ==> offset = 8
[  365.049238][  T444] ==> offset = 8
[  365.052720][  T445] ==> offset = 64
[  365.056390][  T441] ==> offset = 8
[  365.060081][    T1] ==> offset = 8
[  365.063947][  T441] ==> offset = 64
[  365.067505][    T1] ==> offset = 8
[  365.071035][  T444] ==> offset = 64
[  365.074652][  T445] ==> offset = 8
[  365.078847][  T444] ==> offset = 8
[  365.082347][  T445] ==> offset = 64
[  365.086029][  T444] ==> offset = 64
[  365.089660][    T1] ==> offset = 64
[  365.093238][  T441] ==> offset = 8
[  365.096885][    T1] ==> offset = 64
[  365.096894][    T1] ==> offset = 64
[  365.096901][    T1] ==> offset = 64
[  365.096933][    T1] ==> offset = 8
[  365.100643][  T444] ==> offset = 8
[  365.104396][    T1] ==> offset = 8
[  365.108248][  T444] ==> offset = 64
[  365.112036][  T445] ==> offset = 8
[  365.115833][  T441] ==> offset = 64
[  365.119707][  T445] ==> offset = 64
[  365.123678][  T441] ==> offset = 64
[  365.127421][    T1] ==> offset = 8
[  365.131540][  T444] ==> offset = 64
[  365.135183][  T445] ==> offset = 8
[  365.139404][  T444] ==> offset = 64
[  365.142708][  T445] ==> offset = 64
[  365.157560][  T441] ==> offset = 64
[  365.160832][    T1] ==> offset = 8
[  365.164691][  T444] ==> offset = 8
[  365.168668][    T1] ==> offset = 64
[  365.172274][  T441] ==> offset = 8
[  365.175990][    T1] ==> offset = 64
[  365.179305][  T444] ==> offset = 64
[  365.182901][    T1] ==> offset = 64
[  365.182910][    T1] ==> offset = 64
[  365.186647][  T441] ==> offset = 64
[  365.197345][  T445] ==> offset = 8
[  365.200845][  T444] ==> offset = 8
[  365.208525][    T1] ==> offset = 8
[  365.211897][  T444] ==> offset = 64
[  365.215521][  T445] ==> offset = 64
[  365.215551][  T445] ==> offset = 64
[  365.215807][  T445] ==> offset = 64
[  365.219251][  T441] ==> offset = 8
[  365.222791][  T445] ==> offset = 8
[  365.226407][  T444] ==> offset = 8
[  365.229992][    T1] ==> offset = 64
[  365.233498][  T444] ==> offset = 64
[  365.237680][    T1] ==> offset = 8
[  365.240648][  T441] ==> offset = 64
[  365.244204][    T1] ==> offset = 64
[  365.247892][  T441] ==> offset = 8
[  365.247904][  T441] ==> offset = 64
[  365.247924][  T441] ==> offset = 8
[  365.251497][  T133] ==> offset = 8
[  365.255163][  T444] ==> offset = 8
[  365.258739][  T445] ==> offset = 64
[  365.262345][  T444] ==> offset = 64
[  365.266179][  T133] ==> offset = 8
[  365.270266][  T441] ==> offset = 64
[  365.273772][  T133] ==> offset = 8
[  365.278030][  T441] ==> offset = 8
[  365.281126][   T26] ==> offset = 8
[  365.284894][  T444] ==> offset = 8
[  365.288522][  T445] ==> offset = 8
[  365.292114][  T444] ==> offset = 64
[  365.295884][  T445] ==> offset = 64
[  365.299538][  T441] ==> offset = 64
[  365.302976][  T445] ==> offset = 8
[  365.307149][  T133] ==> offset = 8
[  365.310254][   T26] ==> offset = 8
[  365.313854][  T133] ==> offset = 8
[  365.313865][  T133] ==> offset = 8
[  365.324683][   T26] ==> offset = 8
[  365.324694][   T26] ==> offset = 8
[  365.324702][   T26] ==> offset = 8
[  365.328337][  T133] ==> offset = 8
[  365.331822][   T26] ==> offset = 8
[  365.331831][   T26] ==> offset = 8
[  365.339110][  T133] ==> offset = 8
[  365.342747][  T445] ==> offset = 64
[  365.346430][  T133] ==> offset = 64
[  365.350102][  T445] ==> offset = 8
[  365.353679][  T133] ==> offset = 64
[  365.353689][  T133] ==> offset = 64
[  365.357412][  T445] ==> offset = 64
[  365.361923][  T133] ==> offset = 64
[  365.365972][   T26] ==> offset = 8
[  365.365996][   T26] ==> offset = 64
[  365.366004][   T26] ==> offset = 64
[  365.366011][   T26] ==> offset = 64
[  365.369754][  T133] ==> offset = 64
[  365.373328][   T26] ==> offset = 64
[  365.377434][   T77] ==> offset = 8
[  365.381028][  T445] ==> offset = 8
[  365.384481][   T77] ==> offset = 64
[  365.388047][   T26] ==> offset = 64
[  365.388056][   T26] ==> offset = 64
[  365.388064][   T26] ==> offset = 64
[  365.391708][  T133] ==> offset = 64
[  365.395415][  T445] ==> offset = 64
[  365.395715][   T26] ==> offset = 64
[  365.399848][   T77] ==> offset = 8
[  365.404022][  T133] ==> offset = 64
[  365.407380][    T1] ==> offset = 8
[  365.410802][  T133] ==> offset = 64
[  365.414326][    T1] ==> offset = 8
[  365.418337][  T446] ==> offset = 8
[  365.425337][   T77] ==> offset = 64
[  365.428838][  T446] ==> offset = 64
[  365.428993][  T446] ==> offset = 8
[  365.436172][   T77] ==> offset = 8
[  365.436186][   T77] ==> offset = 64
[  365.439836][  T446] ==> offset = 64
[  365.443512][   T77] ==> offset = 8
[  365.447118][  T446] ==> offset = 8
[  365.450962][    T1] ==> offset = 8
[  365.454572][  T446] ==> offset = 64
[  365.461888][    T1] ==> offset = 8
[  365.465626][  T446] ==> offset = 8
[  365.469339][   T77] ==> offset = 64
[  365.472815][  T446] ==> offset = 64
[  365.476473][    T1] ==> offset = 8
[  365.480060][  T446] ==> offset = 8
[  365.483519][    T1] ==> offset = 8
[  365.487079][  T446] ==> offset = 64
[  365.487109][  T446] ==> offset = 64
[  365.487376][  T446] ==> offset = 64
[  365.490826][   T77] ==> offset = 8
[  365.494659][    T1] ==> offset = 8
[  365.498044][   T77] ==> offset = 64
[  365.501617][    T1] ==> offset = 8
[  365.505194][   T77] ==> offset = 8
[  365.508924][  T446] ==> offset = 8
[  365.512427][   T77] ==> offset = 64
[  365.516080][  T446] ==> offset = 64
[  365.516103][  T446] ==> offset = 8
[  365.519728][   T77] ==> offset = 8
[  365.523329][  T446] ==> offset = 64
[  365.527118][   T77] ==> offset = 64
[  365.530836][    T1] ==> offset = 64
[  365.534595][   T77] ==> offset = 8
[  365.538334][  T446] ==> offset = 8
[  365.541639][   T77] ==> offset = 64
[  365.545301][    T1] ==> offset = 64
[  365.545311][    T1] ==> offset = 64
[  365.545318][    T1] ==> offset = 64
[  365.545324][    T1] ==> offset = 64
[  365.545331][    T1] ==> offset = 64
[  365.545339][    T1] ==> offset = 64
[  365.545345][    T1] ==> offset = 64
[  365.545584][    T1] ==> offset = 8
[  365.549401][  T447] ==> offset = 8
[  365.552495][    T1] ==> offset = 64
[  365.556117][  T447] ==> offset = 64
[  365.556188][  T447] ==> offset = 8
[  365.559872][  T446] ==> offset = 64
[  365.563469][  T447] ==> offset = 64
[  365.567061][  T446] ==> offset = 8
[  365.570649][  T447] ==> offset = 8
[  365.574173][  T446] ==> offset = 64
[  365.585057][  T447] ==> offset = 64
[  365.585103][  T447] ==> offset = 8
[  365.589629][    T1] ==> offset = 8
[  365.595898][  T447] ==> offset = 64
[  365.595968][  T447] ==> offset = 8
[  365.595980][  T447] ==> offset = 64
[  365.596067][  T447] ==> offset = 8
[  365.599582][    T1] ==> offset = 8
[  365.603165][  T447] ==> offset = 64
[  365.607120][    T1] ==> offset = 8
[  365.617537][  T448] ==> offset = 8
[  365.621159][  T446] ==> offset = 8
[  365.628272][  T447] ==> offset = 64
[  365.631943][    T1] ==> offset = 8
[  365.635829][  T448] ==> offset = 8
[  365.639335][  T446] ==> offset = 64
[  365.642847][  T448] ==> offset = 8
[  365.646636][    T1] ==> offset = 8
[  365.650556][  T447] ==> offset = 64
[  365.653762][    T1] ==> offset = 8
[  365.657346][  T448] ==> offset = 8
[  365.661231][    T1] ==> offset = 8
[  365.664464][  T448] ==> offset = 8
[  365.668109][    T1] ==> offset = 8
[  365.668133][    T1] ==> offset = 64
[  365.668141][    T1] ==> offset = 64
[  365.671755][  T447] ==> offset = 8
[  365.675243][    T1] ==> offset = 64
[  365.678885][  T447] ==> offset = 64
[  365.682341][    T1] ==> offset = 64
[  365.686081][  T447] ==> offset = 8
[  365.689748][  T448] ==> offset = 8
[  365.693355][  T447] ==> offset = 64
[  365.697031][  T448] ==> offset = 8
[  365.700716][  T447] ==> offset = 8
[  365.704170][  T448] ==> offset = 8
[  365.707744][  T447] ==> offset = 64
[  365.707769][  T447] ==> offset = 8
[  365.711388][    T1] ==> offset = 64
[  365.714992][  T447] ==> offset = 64
[  365.718664][    T1] ==> offset = 64
[  365.722338][  T447] ==> offset = 8
[  365.725924][  T448] ==> offset = 64
[  365.725934][  T448] ==> offset = 64
[  365.729544][  T447] ==> offset = 64
[  365.733064][  T448] ==> offset = 64
[  365.733073][  T448] ==> offset = 64
[  365.747908][    T1] ==> offset = 64
[  365.751435][  T448] ==> offset = 64
[  365.755580][    T1] ==> offset = 64
[  365.759156][  T448] ==> offset = 64
[  365.763204][    T1] ==> offset = 8
[  365.766486][  T448] ==> offset = 64
[  365.766502][  T448] ==> offset = 64
[  365.766620][  T448] ==> offset = 8
[  365.777512][    T1] ==> offset = 64
[  365.781437][   T26] ==> offset = 8
[  365.784739][  T448] ==> offset = 64
[  365.784904][  T448] ==> offset = 8
[  365.788353][   T26] ==> offset = 8
[  365.792012][  T448] ==> offset = 64
[  365.795598][   T26] ==> offset = 64
[  365.795611][   T26] ==> offset = 64
[  365.795837][    T1] ==> offset = 8
[  365.799238][  T448] ==> offset = 8
[  365.802776][    T1] ==> offset = 8
[  365.806528][  T448] ==> offset = 64
[  365.806587][  T448] ==> offset = 8
[  365.810202][    T1] ==> offset = 8
[  365.813705][  T448] ==> offset = 64
[  365.817270][    T1] ==> offset = 8
[  365.817279][    T1] ==> offset = 8
[  365.817286][    T1] ==> offset = 8
[  365.817294][    T1] ==> offset = 8
[  365.820932][  T448] ==> offset = 8
[  365.824638][    T1] ==> offset = 8
[  365.824651][    T1] ==> offset = 64
[  365.824659][    T1] ==> offset = 64
[  365.828265][  T448] ==> offset = 64
[  365.831873][    T1] ==> offset = 64
[  365.835493][  T448] ==> offset = 64
[  365.839246][    T1] ==> offset = 64
[  365.843126][  T448] ==> offset = 64
[  365.846737][    T1] ==> offset = 64
[  365.850464][  T448] ==> offset = 8
[  365.853963][    T1] ==> offset = 64
[  365.857626][  T448] ==> offset = 64
[  365.861681][    T1] ==> offset = 64
[  365.865443][  T448] ==> offset = 8
[  365.869243][    T1] ==> offset = 64
[  365.872779][  T448] ==> offset = 64
[  365.876851][    T1] ==> offset = 8
[  365.879966][  T448] ==> offset = 8
[  365.883574][    T1] ==> offset = 64
[  365.887308][  T448] ==> offset = 64
[  365.890986][   T12] ==> offset = 8
[  365.901804][  T448] ==> offset = 8
[  365.906894][    T1] ==> offset = 8
[  365.909345][  T161] ==> offset = 8
[  365.912603][    T1] ==> offset = 64
[  365.916491][  T449] ==> offset = 8
[  365.919908][   T12] ==> offset = 64
[  365.923509][  T449] ==> offset = 64
[  365.

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
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build2453860011=/tmp/go-build -gno-record-gcc-switches"

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
https://syzkaller.appspot.com/x/error.txt?x=1623c347680000


Tested on:

commit:         89cdf9d5 Merge tag 'net-6.7-rc1' of git://git.kernel.o..
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=97c84b399d02b00b
dashboard link: https://syzkaller.appspot.com/bug?extid=7a9bbb158a7a1071eb27
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1423c347680000

