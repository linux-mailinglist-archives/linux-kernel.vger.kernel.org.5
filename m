Return-Path: <linux-kernel+bounces-37455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 794F483B054
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2911C225F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C481272D6;
	Wed, 24 Jan 2024 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7/1fHU4"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E521272B6;
	Wed, 24 Jan 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118435; cv=none; b=YPl+6pgF2WjyVkUBjnuBM2jHRuUGXQcotktCECcoeKhKclfwDgwSny9Vb/KvP3B2Sycmj/cSNI1YRyB/xxMmFp3ErB+gf2FgUIwJqPoLUFHhfJvllRWOgaCDgp0/Iukk8wa787xRhrAiZ3oC1JxODHs9/0QyP7F01Rs2m8oJWgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118435; c=relaxed/simple;
	bh=QkUjubpofB5Azx+kpt9gh8KxjVh40iHtdBvvB8Y+8qA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RTMPJLp/ZYMPdkaVyMwGYtM04LpnLKoZDkxV7CP3dYPIGJh474mz5LKfeavs2QPKi+uBcPtCXE09pyy0sGkfUyX+BuCo9Xh0ane1tMPzLDRFScl1c3Azjt31PyRUEiFSIqOALCY0C2u2CQYPYOayvsK/OS+nitSpDU3EjeAtZ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7/1fHU4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d72f71f222so24194475ad.1;
        Wed, 24 Jan 2024 09:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706118433; x=1706723233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQxbBT+TSvZsQ3Ou+NOpiUNwjKU/hcS1Evjle7FB36Y=;
        b=R7/1fHU4GkG52F1Sc5CMcp5hYKl9mL339t1pQ76FPq6+m6UAkNucov+Z2fVBrwSzQF
         LEcrNGmoRdQtAeO1KHv7zPcMiqVP0bjD6zBcStjAMUgt4npTQUYET1G7Mzzsu4mi5QRZ
         clXrLq/Fi/IsuEugEIqD1hz5jHtRhct4WntQN9ZMJavyP2ez+8isZ99hnmoK9Dansm5C
         vtI2XNTNIjuvxSKJ+kl0mDqQP7mxH04awZVPus1KqUrLa6+sjAHaiTIRUf4QRNhOmdn+
         3JNa3HdSlXMKgg/rai5NblyuD0Sg3Nsie75fHKwZ0uGDg2oEqwDZWfeAyx6vxCEet6h4
         Gpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118433; x=1706723233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQxbBT+TSvZsQ3Ou+NOpiUNwjKU/hcS1Evjle7FB36Y=;
        b=jhb1z1RzyPDTO+TR2xxhujQv2uhfopBoRoVVmAaX23k9Pzgq9jyh0W0SFa1dhi+QZM
         yf4D06iSQjofT0KqMRD6mGZC8blaXlpRO3tczpUIY8OVf8xLXDNHvLb7b/GGa9tftv2Y
         pLZWh5T7yLc3oHd77of+Qo3Sr0XZz/JH2uoNDS6y98pCz2lcuFhcDJpMZ3GgKI4w0a6h
         JVNGxOMIgvBiYg2yk4MklhB8cIA9FDKYVV0dx/iB5UTDmy37Wgg9jpD+qUMD2fixwwuh
         RPsgzVAmsUxXbJDwEEaIIE6WXz3CgEZnoKhqFFS0PaTII1cBxkY6rs1aYneNtU4JWlCl
         4g2A==
X-Gm-Message-State: AOJu0Yw6cBKp77hb9sV9KqQHjl8kEKbW0darRKPEgtdcyzXL6+DA2GP5
	yELU3yscHBG4BnW46ca8mQcE4axuwQ2/Xlne3yWYWyJByq709WL5
X-Google-Smtp-Source: AGHT+IGzjoUJsq3bpdJ+H9jC6qnkNhXQggYHoUKJzgWHNvJuuMcNny1bRMvoJ80FJJykhqBP2FqGFQ==
X-Received: by 2002:a17:902:d902:b0:1d6:fcc3:c99a with SMTP id c2-20020a170902d90200b001d6fcc3c99amr1060350plz.62.1706118433148;
        Wed, 24 Jan 2024 09:47:13 -0800 (PST)
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902b20700b001d740687d1csm6144225plr.193.2024.01.24.09.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:47:12 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1 0/8] netconsole: Add userdata append support
Date: Wed, 24 Jan 2024 09:46:58 -0800
Message-ID: <20240124174711.1906102-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Add the ability to add custom userdata to every outbound netconsole message
as a collection of key/value pairs, allowing users to add metadata to every
netconsole message which can be used for  for tagging, filtering, and
aggregating log messages.

In a previous patch series the ability to prepend the uname release was
added towards the goals above. This patch series builds on that
idea to allow any userdata, keyed by a user provided name, to be
included in netconsole messages.

If CONFIG_NETCONSOLE_DYNAMIC is enabled an additional userdata
directory will be presented in the netconsole configfs tree, allowing
the addition of userdata entries.

    /sys/kernel/config/netconsole/
			<target>/
				enabled
				release
				dev_name
				local_port
				remote_port
				local_ip
				remote_ip
				local_mac
				remote_mac
				userdata/
					<key>/
						value
					<key>/
						value
          ...

Testing for this series is as follows:

Build every patch without CONFIG_NETCONSOLE_DYNAMIC, and also built
with CONFIG_NETCONSOLE_DYNAMIC enabled for every patch after the config
option was added

Test Userdata configfs

    # Adding userdata
    cd /sys/kernel/config/netconsole/ && mkdir cmdline0 && cd cmdline0
    mkdir userdata/release && echo hotfix1 > userdata/release/value
    preview=3D$(for f in `ls userdata`; do echo $f=3D$(cat userdata/$f/valu=
e); done)
    [[ "$preview" =3D=3D $'release=3Dhotfix1' ]] && echo pass || echo fail
    mkdir userdata/testing && echo something > userdata/testing/value
    preview=3D$(for f in `ls userdata`; do echo $f=3D$(cat userdata/$f/valu=
e); done)
    [[ "$preview" =3D=3D $'release=3Dhotfix1\ntesting=3Dsomething' ]] && ec=
ho pass || echo fail
    #
    # Removing Userdata
    rmdir userdata/testing
    preview=3D$(for f in `ls userdata`; do echo $f=3D$(cat userdata/$f/valu=
e); done)
    [[ "$preview" =3D=3D $'release=3Dhotfix1' ]] && echo pass || echo fail
    rmdir userdata/release
    [[ `cat userdata/complete` =3D=3D $'release=3Dhotfix1' ]] && echo pass =
|| echo fail
    #
    # Adding userdata key with too large of 6.7.0-rc8-virtme,12,481,1795410=
4,-directory name [<54 chars]
    mkdir userdata/testing12345678901234567890123456789012345678901234567890
    [[ $? =3D=3D 1 ]] && echo pass || echo fail
    #
    # Adding userdata value with too large of value [<200 chars]
    mkdir userdata/testing
    echo `for i in {1..201};do printf "%s" "v";done` > userdata/testing/val=
ue
    [[ $? =3D=3D 1 ]] && echo pass || echo fail
    rmdir userdata/testing

- Output:

    pass
    pass
    pass
    pass
    pass
    mkdir: cannot create directory =E2=80=98cmdline0/userdata/testing123456=
78901234567890123456789012345678901234567890=E2=80=99: File name too long
    pass
    bash: echo: write error: Message too long
    pass

Test netconsole messages (w/ msg fragmentation)

    echo `for i in {1..996};do printf "%s" "v";done` > /dev/kmsg

- Output:

    6.7.0-rc8-virtme,12,484,84321212,-,ncfrag=3D0/997;vvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv6.7.0-rc8-virtme,12,484,84321212,-,ncfrag=3D=
952/997;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

Test empty userdatum

    cd /sys/kernel/config/netconsole/ && mkdir cmdline0
    mkdir cmdline0/userdata/empty
    echo test > /dev/kmsg
    rmdir cmdline0/userdata/empty

- Output:

Test netconsole messages (w/o userdata fragmentation)

    cd /sys/kernel/config/netconsole/ && mkdir cmdline0
    mkdir cmdline0/userdata/release && echo hotfix1 > cmdline0/userdata/rel=
ease/value
    mkdir cmdline0/userdata/testing && echo something > cmdline0/userdata/t=
esting/value
    echo test > /dev/kmsg
    rmdir cmdline0/userdata/release
    rmdir cmdline0/userdata/testing

- Output:
    6.7.0-rc8-virtme,12,500,1646292204,-;test
    release=3Dhotfix1
    testing=3Dsomething

Test netconsole messages (w/ long body fragmentation)
    cd /sys/kernel/config/netconsole/ && mkdir cmdline0
    mkdir cmdline0/userdata/release && echo hotfix1 > cmdline0/userdata/rel=
ease/value
    mkdir cmdline0/userdata/testing && echo something > cmdline0/userdata/t=
esting/value
    echo `for i in {1..996};do printf "%s" "v";done` > /dev/kmsg
    rmdir cmdline0/userdata/release
    rmdir cmdline0/userdata/testing

- Output:
    6.7.0-rc8-virtme,12,486,156664417,-,ncfrag=3D0/1031;vvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv=
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv6.7.0-rc8-virtme,12,486,156664417,-,ncfrag=
=3D950/1031;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    release=3Dhotfix1
    testing=3Dsomething

Test netconsole messages (w/ long userdata fragmentation)

    cd /sys/kernel/config/netconsole/ && mkdir cmdline0
    LOREM=3D"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed d=
o eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad mi=
nim veniam, quis nostrud exercitation ullamco laboris nisi ut"
    for i in {0..5}; do mkdir cmdline0/userdata/value${i} && echo ${LOREM} =
> cmdline0/userdata/value${i}/value; done
    echo test > /dev/kmsg
    for i in {0..5}; do rmdir cmdline0/userdata/value${i}; done

- Output:
    6.7.0-rc8-virtme,12,487,221763007,-,ncfrag=3D0/1241;test
    value0=3DLorem ipsum dolor sit amet, consectetur adipiscing elit, sed d=
o eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad mi=
nim veniam, quis nostrud exercitation ullamco laboris nisi ut
    value1=3DLorem ipsum dolor sit amet, consectetur adipiscing elit, sed d=
o eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad mi=
nim veniam, quis nostrud exercitation ullamco laboris nisi ut
    value2=3DLorem ipsum dolor sit amet, consectetur adipiscing elit, sed d=
o eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad mi=
nim veniam, quis nostrud exercitation ullamco laboris nisi ut
    value3=3DLorem ipsum dolor sit amet, consectetur adipiscing elit, sed d=
o eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad mi=
nim veniam, quis nostrud exercitation ullamco laboris nisi ut
    value4=3DLorem ipsum dolor sit amet, consectetur adipiscing elit, sed d=
o eiusmod tempor incididunt ut labore et dolore magn6.7.0-rc8-virtme,12,487=
,221763007,-,ncfrag=3D950/1241;a aliqua. Ut enim ad minim veniam, quis nost=
rud exercitation ullamco laboris nisi ut
    value5=3DLorem ipsum dolor sit amet, consectetur adipiscing elit, sed d=
o eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad mi=
nim veniam, quis nostrud exercitation ullamco laboris nisi ut


Matthew Wood (8):
  net: netconsole: cleanup formatting lints
  net: netconsole: move netconsole_target config_item to config_group
  net: netconsole: move newline trimming to function
  net: netconsole: add docs for appending netconsole user data
  net: netconsole: add a userdata config_group member to
    netconsole_target
  net: netconsole: cache userdata formatted string in netconsole_target
  net: netconsole: append userdata to netconsole messages
  net: netconsole: append userdata to fragmented netconsole messages

 Documentation/networking/netconsole.rst |  68 +++++
 drivers/net/netconsole.c                | 355 ++++++++++++++++++++----
 2 files changed, 369 insertions(+), 54 deletions(-)

--
2.43.0


