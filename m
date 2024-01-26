Return-Path: <linux-kernel+bounces-40807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E96DA83E654
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F91B283F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D55857868;
	Fri, 26 Jan 2024 23:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs2potCy"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ED657301;
	Fri, 26 Jan 2024 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310833; cv=none; b=rNizqPgF9vjnkNV2L4H0haHxGs1+qGLLfsFyWWVmOL1Rs2vtGHFRfEaOjeLOtgcrokzcJexuzml0/f6UkwiipSjGvL1dBuxv1YU6f4tT9n1Mn7muMQ4saiOld54PJxZEjONo760c3PaDLb6BNhdFiS4bR4WEzaXEknXIr0UqBuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310833; c=relaxed/simple;
	bh=DNs0f634DOEinqxZXeKaL1qWD6rVCN55SpKgB4gtwt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zen/IZcVBEAA2JDLxMsS0XG/NHfXtM9Do4xGwU/in76L9vwnQsEl212HbTKQv0+yVqTIFYQwtRRqy8iwzVUZybEfqouB6W37ltHAEWmJUzzURD+afyXJJL2BrxYwRIBdCMHvuRLq05hXkVrp32PtWV0nq5mS9DIL1sQm+IOOCJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs2potCy; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ddc268ce2bso868829b3a.0;
        Fri, 26 Jan 2024 15:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706310830; x=1706915630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wM+F4vop3e0PT/3SYYTMEP7aWNHCVXfd37lACWLfDmo=;
        b=Xs2potCy5tZ41Rgw62ewjsA5+Pp9Pskfgh0cs0jyPocNrrGliuEp503GBcAdcKOEa1
         n+2vl6GaKkQKB1WuDR3yN8+jkh7pY3ubla7q7vVHyXK+q1t1RcvYjn0rqvo5IM58fRvR
         lOGUVjh6XECTIjg3ixUQN6toUw6RZ+r3ZenHNd0Lzgnrj8UG8uC590Yfz5W6sjuaulfb
         K+HzTgUssBQcT8F6kPPxejI7bM7sNwhli/9tySPL1Tdc7aXvULQDEyMENrDZfzYeYvmv
         CvgTFlm+EDMhI7J5VvFpC9HSrbQHT/oXeBMFVuYC5Mb9qGkuCjhrNFU8IaycLcPPdLba
         aVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310830; x=1706915630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wM+F4vop3e0PT/3SYYTMEP7aWNHCVXfd37lACWLfDmo=;
        b=eKDTmcO4DzNCDzVE/5ZZUztk24SHX7jTRCVaoZJexvmtpywFq951FMdKFIqgXf7b4J
         nfgWYdlKtvze0pZN2AygZKfpWqpYcAhA3k6BaM7lFrx21Yrr8qJWTjL2EbOMx7uIT3oG
         zYJQdI1EAUh9H1aPEqLD+c64Dtm46nIMy7r+mxM+vkfXvK3nIv785+lUNwmIJtlGQtqY
         WpRHc6GcyCT1dNqEsX+1dV7w8zqaXpYXfI/coFzygZaXBw1PIr6qz4RQSOeRivqUs/gx
         3+iY7LeAghFJyDDhcxYAHkW4ove+q39w/v5c2kc6FEOGLs1m6hlz2h09F1oGtsDG/wFD
         TgQA==
X-Gm-Message-State: AOJu0Yx/dwYgWtgZWxVg5keIl8zZh6H+J0Q7lL2IY/j+k5cNezn1Qhcb
	d/aedoIoV+sesy/FTORRRlgWIqQWjth4I3a5Zot5z9WwQpNKoskW
X-Google-Smtp-Source: AGHT+IG1IoRDZ8A+DxRfmYz8nrwogMqLPX5xyoFBBurJotYtazyh4PsshNcBifyobUY006B6zPmx2g==
X-Received: by 2002:a62:5bc5:0:b0:6db:ca95:e689 with SMTP id p188-20020a625bc5000000b006dbca95e689mr748309pfb.34.1706310830491;
        Fri, 26 Jan 2024 15:13:50 -0800 (PST)
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id r18-20020aa79892000000b006d9a13b491csm1597613pfl.212.2024.01.26.15.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 15:13:50 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leitao@debian.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/8] netconsole: Add userdata append support
Date: Fri, 26 Jan 2024 15:13:35 -0800
Message-ID: <20240126231348.281600-1-thepacketgeek@gmail.com>
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

v1->v2:
 * Updated netconsole_target docs, kdoc is now clean

--------

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
 drivers/net/netconsole.c                | 360 ++++++++++++++++++++----
 2 files changed, 373 insertions(+), 55 deletions(-)

--
2.43.0


