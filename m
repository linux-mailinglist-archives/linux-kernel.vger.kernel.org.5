Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3191575FCE9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjGXRHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGXRHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:07:51 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C843A9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:07:50 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-63d0228d32bso6792376d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690218469; x=1690823269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uw0GesN0rmWRh+DmayFGFLT8xsf2nFXUBbffJzXUQmc=;
        b=yQqvvunZWdFiy+w7MNNZ//ZiYJUe/JYwsEPAMOAuzMnVsxc9q25s8iviP7QtPQyBK/
         CeY75Zkf+57SpSYN5dlJoTkcwinzxriV2eicBdfYG1pBOxEsyZ6+et846Ua9dfCKbgc3
         MUCAgWoYRdeh6M15XiJgKYwJCa9/aMUoUb4vR2mADsXonxCqoAtveV6kJJMSHUR5W751
         fWJRf2kJV/KsglYpW34OYBh32tiHrHC7ab6Mk/X8hxqMRMAwNCVCVzim6mQ4dN+kRYq2
         tRSc6pEdkoS6RJdPkhR2MlRa7EmEb/Jb18zswzvEcCAEEdbN8+8w1toIylcd2h37h1c3
         fOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690218469; x=1690823269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uw0GesN0rmWRh+DmayFGFLT8xsf2nFXUBbffJzXUQmc=;
        b=LdhIfzpKqCk3ZhrQ1mLESDuRmDiah9kQbL+8cDC+dOVTRYuxH/8yBbyUR+jzb5X8fw
         /syWBh1iYVxSzZ1h0xC/5b9PrvlDT8DVVTU5ojnQmnf8vc4HSLcpihNBttqXjKV1ospt
         B/QGTIcjGCBtROnrwzo/udX9U1Jfrtjeges6EUHOCw7AiQuWJF0HIdFjvShya51iW4t1
         QQPMnLnVMoKFTz0FV1G5DT+pmh4bOBMT0tqZkmcmZUbDzLeWu2AGXzeTidfmJLRIKf09
         vWSVDGrDPHqYkvzYmIAwebB7Bia50ypKVmimO6daMlUy5zjog1a7hHH/RQQQvS3DxoKy
         yCcw==
X-Gm-Message-State: ABy/qLaZ5EVbfglcB8PRUn3D+IR8iAdCSmhkSYjHIO1fXArU/MwN97P7
        0CWBPDtQ779g4OoDPZe0C2g6tRvtvefqWM6MqPcTnjO5x1ucY4cD9I0=
X-Google-Smtp-Source: APBJJlHzvogcOM4+QS3uHKnCCLcH5s74N9Df9/sVTwJHHZCKxvEdbXGa4EZDOxDcwhZC+MQm3x4ydCXgpVMQTl/RTMM=
X-Received: by 2002:a05:6214:88d:b0:635:3892:a2b0 with SMTP id
 cz13-20020a056214088d00b006353892a2b0mr361506qvb.15.1690218469268; Mon, 24
 Jul 2023 10:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <202307201141.PYWS6ird-lkp@intel.com> <840cdf34-f38e-ab37-623f-9744c3436350@grimberg.me>
In-Reply-To: <840cdf34-f38e-ab37-623f-9744c3436350@grimberg.me>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jul 2023 10:07:38 -0700
Message-ID: <CAKwvOdnfHeEZcKYJh_VPoMfB5oDa3aAU0CYVt-6TNc3a6Jtc6w@mail.gmail.com>
Subject: Re: drivers/nvme/host/tcp.c:835:12: warning: stack frame size (2256)
 exceeds limit (2048) in 'nvme_tcp_recv_skb'
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     kernel test robot <lkp@intel.com>,
        Varun Prakash <varun@chelsio.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 12:46=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> w=
rote:
>
>
>
> On 7/20/23 06:10, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   bfa3037d828050896ae52f6467b6ca2489ae6fb1
> > commit: c2700d2886a87f83f31e0a301de1d2350b52c79b nvme-tcp: send H2CData=
 PDUs based on MAXH2CDATA
> > date:   1 year, 5 months ago
> > config: riscv-randconfig-r042-20230720 (https://download.01.org/0day-ci=
/archive/20230720/202307201141.PYWS6ird-lkp@intel.com/config)

^ it's from a randconfig...the sanitizers tend to blow up stack usage.

> > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.gi=
t 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > reproduce: (https://download.01.org/0day-ci/archive/20230720/2023072011=
41.PYWS6ird-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202307201141.PYWS6ird-l=
kp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >>> drivers/nvme/host/tcp.c:835:12: warning: stack frame size (2256) exce=
eds limit (2048) in 'nvme_tcp_recv_skb' [-Wframe-larger-than]
> >       835 | static int nvme_tcp_recv_skb(read_descriptor_t *desc, struc=
t sk_buff *skb,
> >           |            ^
> >     1 warning generated.
> >
> >
> > vim +/nvme_tcp_recv_skb +835 drivers/nvme/host/tcp.c
> >
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  834
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03 @835  static int nvme_tcp_recv_=
skb(read_descriptor_t *desc, struct sk_buff *skb,
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  836                           =
    unsigned int offset, size_t len)
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  837  {
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  838          struct nvme_tcp_q=
ueue *queue =3D desc->arg.data;
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  839          size_t consumed =
=3D len;
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  840          int result;
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  841
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  842          while (len) {
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  843                  switch (n=
vme_tcp_recv_state(queue)) {
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  844                  case NVME=
_TCP_RECV_PDU:
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  845                          r=
esult =3D nvme_tcp_recv_pdu(queue, skb, &offset, &len);
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  846                          b=
reak;
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  847                  case NVME=
_TCP_RECV_DATA:
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  848                          r=
esult =3D nvme_tcp_recv_data(queue, skb, &offset, &len);
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  849                          b=
reak;
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  850                  case NVME=
_TCP_RECV_DDGST:
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  851                          r=
esult =3D nvme_tcp_recv_ddgst(queue, skb, &offset, &len);
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  852                          b=
reak;
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  853                  default:
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  854                          r=
esult =3D -EFAULT;
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  855                  }
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  856                  if (resul=
t) {
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  857                          d=
ev_err(queue->ctrl->ctrl.device,
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  858                           =
       "receive failed:  %d\n", result);
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  859                          q=
ueue->rd_enabled =3D false;
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  860                          n=
vme_tcp_error_recovery(&queue->ctrl->ctrl);
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  861                          r=
eturn result;
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  862                  }
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  863          }
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  864
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  865          return consumed;
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  866  }
> > 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  867
> >
> > :::::: The code at line 835 was first introduced by commit
> > :::::: 3f2304f8c6d6ed97849057bd16fee99e434ca796 nvme-tcp: add NVMe over=
 TCP host driver
> >
> > :::::: TO: Sagi Grimberg <sagi@lightbitslabs.com>
> > :::::: CC: Christoph Hellwig <hch@lst.de>
> >
>
> I don't understand how the stack frame size is that big. Looks like a
> wrong complaint?
>


--=20
Thanks,
~Nick Desaulniers
