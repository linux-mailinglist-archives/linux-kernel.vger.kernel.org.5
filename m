Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50E3766050
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 01:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjG0Xsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 19:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjG0Xsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 19:48:33 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84A330FB;
        Thu, 27 Jul 2023 16:48:28 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9cf2b1309so1449641fa.0;
        Thu, 27 Jul 2023 16:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690501707; x=1691106507;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KNJRe0u3UDdtgnNpYJpi7hgBUl71LQ0F6FbMEfczzTg=;
        b=Rh7Eiy1LH2qkzvPXFMGXsMJscpLmmzQwv6DtBXt2z+PdT8LL41GUpkvYc5u9cq/p/h
         j4Rcyz6lciwkYFRXjOEdAv/kzNZ/KZGSJQ35iToSaFPOgyDjbFPbKJzBZ1rc84T+c3lc
         oqn59uMe9C1rgikVOWRT2KG6rdxkTMnc+V9Scsxlhx0zM+DD+gmEhhesmrRKAtzNH5mp
         dr5NdQi+LZgmebUuRpmwH6SuPRcB2wKhH6CmmAnitdbzIkNTXil/qSOCAUwmO02W3ErF
         irvy6GilhMVXXIRX5LIV7/8yb4xa/BKbcL0vFV7ReB1Hrq9sWw26skkb2tDX9w638AdV
         HzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690501707; x=1691106507;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KNJRe0u3UDdtgnNpYJpi7hgBUl71LQ0F6FbMEfczzTg=;
        b=YlvM8zoCgdmIfOoTgPbK9mRizfbmqTeNcRWtkVRtXi6Zkkpvo3UWpGux8ESvzQKuAU
         UFO8HFULT+sZp93OgIMpaSDlToxmrgepBV5poGv/+Mt+0V9urw5k+R7XB9SRHo32bxLP
         3jqrA7XF5nrDQSgigVNu/a3In6ps/lu9EqxgaVn8LakLdSaj/zDqKitoJznnp67uDXT+
         1p774nXKguLEYyDAPU5Wy3ccSZbCMVBNBAPhump25zt0OjXNv2ajqxn070Ag0Y2os2bG
         xi+r98yQRIfW9cT3ytD0ovBrSFxtejECbpETcvKCVR5B5mgFD/4lUmSuj2c0X4c8FF2I
         BJkw==
X-Gm-Message-State: ABy/qLbz7k7+sFv218UW4L+GEITjdVVJ1rzdAd30J8J/OhTaDOp00oCa
        BF8bLUKvT967gXexozfKWIo=
X-Google-Smtp-Source: APBJJlGID2TQyMBqk29v+gXxU1ktiSZFSyXkA59Mojx0edSfKkn+XFPSFfT35tVfJLv5XIkqubTvQQ==
X-Received: by 2002:a2e:b4b1:0:b0:2b9:b1fb:5ff4 with SMTP id q17-20020a2eb4b1000000b002b9b1fb5ff4mr1283925ljm.21.1690501706396;
        Thu, 27 Jul 2023 16:48:26 -0700 (PDT)
Received: from akanner-r14. ([77.222.25.46])
        by smtp.gmail.com with ESMTPSA id v20-20020a2e9614000000b002b9af8422a8sm614949ljh.130.2023.07.27.16.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 16:48:25 -0700 (PDT)
Message-ID: <64c30249.2e0a0220.f779a.1c31@mx.google.com>
X-Google-Original-Message-ID: <ZMMCRdU5qvCMGRgL@akanner-r14.>
Date:   Fri, 28 Jul 2023 02:48:21 +0300
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
        David Ahern <dsahern@gmail.com>, brouer@redhat.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH v3] drivers: net: prevent tun_get_user() to exceed xdp
 size limits
References: <20230725155403.796-1-andrew.kanner@gmail.com>
 <CACGkMEt=Cd8J995+0k=6MT1Pj=Fk9E_r2eZREptLt2osj_H-hA@mail.gmail.com>
 <ab722ec1-ae45-af1f-b869-e7339402c852@redhat.com>
 <179979e6-eb8a-0300-5445-999b9366250a@gmail.com>
 <0c06b067-349c-9fe2-2cc3-36c149fd5277@gmail.com>
 <CACGkMEsYzd1FphP-Ym9T9YjA9ZNBw7Mnw5xQ75dytQMJxDK3cg@mail.gmail.com>
 <220fc36ba1086c1390ba087d08561b61762c965a.camel@redhat.com>
 <3659ea35-8d03-aae7-53c0-09181bb1b69d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GHBU06YYG/OowSDC"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3659ea35-8d03-aae7-53c0-09181bb1b69d@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GHBU06YYG/OowSDC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jul 27, 2023 at 01:13:10PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 27/07/2023 11.30, Paolo Abeni wrote:
> > On Thu, 2023-07-27 at 14:07 +0800, Jason Wang wrote:
> > > On Thu, Jul 27, 2023 at 8:27 AM David Ahern <dsahern@gmail.com> wrote:
> > > > 
> > > > On 7/26/23 1:37 PM, David Ahern wrote:
> > > > > On 7/26/23 3:02 AM, Jesper Dangaard Brouer wrote:
> > > > > > Cc. John and Ahern
> > > > > > 
> > > > > > On 26/07/2023 04.09, Jason Wang wrote:
> > > > > > > On Tue, Jul 25, 2023 at 11:54 PM Andrew Kanner
> > > > > > > <andrew.kanner@gmail.com> wrote:
> > > > > > > > 
> > > > > > > > Syzkaller reported the following issue:
> > > > > > > > =======================================
> > > > > > > > Too BIG xdp->frame_sz = 131072
> > > > > > 
> > > > > > Is this a contiguous physical memory allocation?
> > > > > > 
> > > > > > 131072 bytes equal order 5 page.
> > > > > > 
> > > > > > Looking at tun.c code I cannot find a code path that could create
> > > > > > order-5 skb->data, but only SKB with order-0 fragments.  But I guess it
> > > > > > is the netif_receive_generic_xdp() what will realloc to make this linear
> > > > > > (via skb_linearize())
> > > > > 
> > > > > 
> > > > > get_tun_user is passed an iov_iter with a single segment of 65007
> > > > > total_len. The alloc_skb path is hit with an align size of only 64. That
> > > > > is insufficient for XDP so the netif_receive_generic_xdp hits the
> > > > > pskb_expand_head path. Something is off in the math in
> > > > > netif_receive_generic_xdp resulting in the skb markers being off. That
> > > > > causes bpf_prog_run_generic_xdp to compute the wrong frame_sz.
> > > > 
> > > > 
> > > > BTW, it is pskb_expand_head that turns it from a 64kB to a 128 kB
> > > > allocation. But the 128kB part is not relevant to the "bug" here really.
> > > > 
> 
> True, it is another "bug"/unexpected-behavior that SKB gets reallocated
> to be 128KiB. We should likely solve this in another patch.
> 
> > > > The warn on getting tripped in bpf_xdp_adjust_tail is because xdp
> > > > generic path is skb based and can have a frame_sz > 4kB. That's what the
> > > > splat is about.
> 
> Agree, that the warn condition should be changed, even removed.
> It is interesting that this warn caught this unexpected-behavior of
> expanding to 128KiB.
> 
> > > 
> > > Other possibility:
> > > 
> > > tun_can_build_skb() doesn't count XDP_PACKET_HEADROOM this may end up
> > > with producing a frame_sz which is greater than PAGE_SIZE as well in
> > > tun_build_skb().
> 
> True, and the way I read the tun_build_skb() code, via
> skb_page_frag_refill(),
> it can produce an SKB with data size (buflen) upto order-3 = 32KiB
> (SKB_FRAG_PAGE_ORDER).
> 
> Thus, the existing check in tun_can_build_skb() for PAGE_SIZE can/should be
> relaxed?
> (Please correct me as I don't fully understand tun_get_user() code)
> 
> > > 
> > > And rethink this patch, it looks wrong since it basically drops all
> > > packets whose buflen is greater than PAGE_SIZE since it can't fall
> > > back to tun_alloc_skb().
> > > 
> 
> I agree, this is why I reacted, as this version of the patch could
> potentially cause issues and packet drops.
> 
> > > > 
> > > > Perhaps the solution is to remove the WARN_ON.
> > > 
> > > Yes, that is what I'm asking if this warning still makes sense in V1.
> > 
> > I understand the consensus is solving the issue by changing/removing
> > the WARN_ON() in XDP. I think it makes sense, I guess the same warn can
> > be reached via packet socket xmit on veth or similar topology.
> > 
> 
> Yes, we can completely remove this check.  The original intend was to
> catch cases where XDP drivers have not been updated to use xdp.frame_sz,
> but that is not longer a concern (since xdp_init_buff).
> 
> It was added (by me) in commit:
>  - c8741e2bfe87 ("xdp: Allow bpf_xdp_adjust_tail() to grow packet size")
>    - v5.8-rc1
>  - as part of merge 5cc5924d8315
> 
> I'm sure it is safe to remove since commit:
>  - 43b5169d8355 ("net, xdp: Introduce xdp_init_buff utility routine")
>    - v5.12-rc1
> 
> where we introduced xdp_init_buff() helper, which all XDP driver use today.
> Question is what "Fixes:" tag should the patch have?
> 
> To Andrew, will you
>  (1) send a new patch that removes this check instead?
>  (2) have cycles to investigate why the unexpected-behavior of
> expanding to 128KiB happens?
> 
> --Jesper
> 

Thanks, everyone.

If we summarize the discussion - there are 3 issues here:
1. tun_can_build_skb() doesn't count XDP_PACKET_HEADROOM (minor and
   most trivial)
2. WARN_ON_ONCE from net/core/filter.c, which may be too strict / not
   needed at all.
3. strange behaviour with reallocationg SKB (65007 -> 131072)

I can check these issues. I have to dive a little deeper with 2-3,
most likely with kgdb and syzkaller repro. But seems this is not
somewhat urgent and lives quite a long time without being noticed.

BTW: Attached the ftrace logs using the original syzkaller repro
(starting with tun_get_user()). They answer Jesper's question about
contiguous physical memory allocation (kmem_cache_alloc_node() /
kmalloc_reserve()). But I'll check it one more time before submitting
a new PATCH V4 or another patch / patch series.

-- 
Andrew Kanner

--GHBU06YYG/OowSDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="tracecmd-report-tun_xdp-short.log"

a.out-4609  [003]    50.323886: funcgraph_entry:                   |  tun_get_user() {
a.out-4609  [003]    50.323889: funcgraph_entry:                   |    sock_alloc_send_pskb() {
a.out-4609  [003]    50.323890: funcgraph_entry:                   |      alloc_skb_with_frags() {
a.out-4609  [003]    50.323890: funcgraph_entry:                   |        __alloc_skb() {
a.out-4609  [003]    50.323891: funcgraph_entry:                   |          kmem_cache_alloc_node() {
...
a.out-4609  [003]    50.324133: funcgraph_entry:                   |          kmalloc_reserve() {
...
a.out-4609  [003]    50.324155: funcgraph_entry:        0.730 us   |          __build_skb_around();
...
a.out-4609  [003]    50.324160: funcgraph_entry:        0.630 us   |    skb_put();
a.out-4609  [003]    50.324161: funcgraph_entry:                   |    skb_copy_datagram_from_iter() {
...
a.out-4609  [003]    50.324785: funcgraph_entry:        0.720 us   |    eth_type_trans();
a.out-4609  [003]    50.324786: funcgraph_entry:                   |    __skb_flow_dissect() {
a.out-4609  [003]    50.324787: funcgraph_entry:        0.620 us   |      __rcu_read_lock();
a.out-4609  [003]    50.324788: funcgraph_entry:        0.620 us   |      __rcu_read_unlock();
a.out-4609  [003]    50.324790: funcgraph_exit:         4.340 us   |    }
a.out-4609  [003]    50.324791: funcgraph_entry:        0.640 us   |    __local_bh_disable_ip();
a.out-4609  [003]    50.324793: funcgraph_entry:        0.660 us   |    __rcu_read_lock();
a.out-4609  [003]    50.324794: funcgraph_entry:                   |    do_xdp_generic() {
a.out-4609  [003]    50.324795: funcgraph_entry:                   |      pskb_expand_head() {
a.out-4609  [003]    50.324796: funcgraph_entry:                   |        kmalloc_reserve() {
a.out-4609  [003]    50.324796: funcgraph_entry:        0.610 us   |          kmalloc_size_roundup();
a.out-4609  [003]    50.324797: funcgraph_entry:                   |          __kmalloc_node_track_caller() {
a.out-4609  [003]    50.324798: funcgraph_entry:                   |            __kmalloc_large_node() {
a.out-4609  [003]    50.324799: funcgraph_entry:                   |              __alloc_pages() {
a.out-4609  [003]    50.324799: funcgraph_entry:        0.600 us   |                should_fail_alloc_page();
a.out-4609  [003]    50.324800: funcgraph_entry:                   |                get_page_from_freelist() {
a.out-4609  [003]    50.324801: funcgraph_entry:        0.640 us   |                  __zone_watermark_ok();
a.out-4609  [003]    50.324802: funcgraph_entry:                   |                  _raw_spin_lock_irqsave() {
a.out-4609  [003]    50.324803: funcgraph_entry:        0.600 us   |                    preempt_count_add();
a.out-4609  [003]    50.324804: funcgraph_exit:         1.810 us   |                  }
a.out-4609  [003]    50.324805: funcgraph_entry:        0.620 us   |                  __mod_zone_page_state();
a.out-4609  [003]    50.324806: funcgraph_entry:                   |                  _raw_spin_unlock_irqrestore() {
a.out-4609  [003]    50.324807: funcgraph_entry:        0.610 us   |                    preempt_count_sub();
a.out-4609  [003]    50.324808: funcgraph_exit:         1.800 us   |                  }
a.out-4609  [003]    50.324809: funcgraph_entry:                   |                  prep_new_page() {
a.out-4609  [003]    50.324811: funcgraph_entry:        1.040 us   |                    prep_compound_page();
a.out-4609  [003]    50.324812: funcgraph_exit:         3.560 us   |                  }
a.out-4609  [003]    50.324813: funcgraph_exit:       + 12.300 us  |                }
a.out-4609  [003]    50.324813: funcgraph_exit:       + 14.700 us  |              }
a.out-4609  [003]    50.324814: funcgraph_entry:        0.640 us   |              mod_node_page_state();
a.out-4609  [003]    50.324815: funcgraph_exit:       + 17.120 us  |            }
a.out-4609  [003]    50.324816: funcgraph_exit:       + 18.310 us  |          }
a.out-4609  [003]    50.324816: funcgraph_exit:       + 20.700 us  |        }
...
a.out-4609  [003]    50.324857: funcgraph_entry:                   |      bpf_prog_run_generic_xdp() {
a.out-4609  [003]    50.324858: funcgraph_entry:                   |        __bpf_prog_run32() {
a.out-4609  [003]    50.324858: funcgraph_entry:                   |          ___bpf_prog_run() {
a.out-4609  [003]    50.324859: funcgraph_entry:                   |            bpf_xdp_adjust_tail() {
a.out-4609  [003]    50.324860: funcgraph_entry:                   |              __warn_printk() {
a.out-4609  [003]    50.324861: funcgraph_entry:                   |                _printk() {
--GHBU06YYG/OowSDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tracecmd-report-tun_xdp.log"

CPU 0 is empty
CPU 1 is empty
CPU 2 is empty
CPU 4 is empty
CPU 5 is empty
CPU 6 is empty
CPU 7 is empty
cpus=8
           a.out-4609  [003]    50.323886: funcgraph_entry:                   |  tun_get_user() {
           a.out-4609  [003]    50.323889: funcgraph_entry:                   |    sock_alloc_send_pskb() {
           a.out-4609  [003]    50.323890: funcgraph_entry:                   |      alloc_skb_with_frags() {
           a.out-4609  [003]    50.323890: funcgraph_entry:                   |        __alloc_skb() {
           a.out-4609  [003]    50.323891: funcgraph_entry:                   |          kmem_cache_alloc_node() {
           a.out-4609  [003]    50.323891: funcgraph_entry:        0.670 us   |            __cond_resched();
           a.out-4609  [003]    50.323893: funcgraph_entry:        0.610 us   |            should_failslab();
           a.out-4609  [003]    50.323894: funcgraph_entry:                   |            stack_trace_save() {
           a.out-4609  [003]    50.323895: funcgraph_entry:                   |              arch_stack_walk() {
           a.out-4609  [003]    50.323895: funcgraph_entry:                   |                __unwind_start() {
           a.out-4609  [003]    50.323896: funcgraph_entry:        0.630 us   |                  get_stack_info();
           a.out-4609  [003]    50.323897: funcgraph_entry:                   |                  update_stack_state() {
           a.out-4609  [003]    50.323898: funcgraph_entry:        0.620 us   |                    unwind_get_return_address_ptr();
           a.out-4609  [003]    50.323899: funcgraph_exit:         1.930 us   |                  }
           a.out-4609  [003]    50.323900: funcgraph_entry:                   |                  unwind_next_frame() {
           a.out-4609  [003]    50.323900: funcgraph_entry:                   |                    update_stack_state() {
           a.out-4609  [003]    50.323901: funcgraph_entry:        0.620 us   |                      unwind_get_return_address_ptr();
           a.out-4609  [003]    50.323902: funcgraph_exit:         1.890 us   |                    }
           a.out-4609  [003]    50.323903: funcgraph_exit:         3.100 us   |                  }
           a.out-4609  [003]    50.323903: funcgraph_exit:         8.070 us   |                }
           a.out-4609  [003]    50.323904: funcgraph_entry:                   |                unwind_get_return_address() {
           a.out-4609  [003]    50.323905: funcgraph_entry:                   |                  __kernel_text_address() {
           a.out-4609  [003]    50.323905: funcgraph_entry:        0.610 us   |                    kernel_text_address();
           a.out-4609  [003]    50.323906: funcgraph_exit:         1.790 us   |                  }
           a.out-4609  [003]    50.323907: funcgraph_exit:         2.990 us   |                }
           a.out-4609  [003]    50.323908: funcgraph_entry:        0.640 us   |                stack_trace_consume_entry();
           a.out-4609  [003]    50.323909: funcgraph_entry:                   |                unwind_next_frame() {
           a.out-4609  [003]    50.323909: funcgraph_entry:                   |                  update_stack_state() {
           a.out-4609  [003]    50.323910: funcgraph_entry:        0.620 us   |                    unwind_get_return_address_ptr();
           a.out-4609  [003]    50.323911: funcgraph_exit:         1.890 us   |                  }
           a.out-4609  [003]    50.323912: funcgraph_exit:         3.090 us   |                }
           a.out-4609  [003]    50.323913: funcgraph_entry:                   |                unwind_get_return_address() {
           a.out-4609  [003]    50.323913: funcgraph_entry:                   |                  __kernel_text_address() {
           a.out-4609  [003]    50.323914: funcgraph_entry:        0.610 us   |                    kernel_text_address();
           a.out-4609  [003]    50.323915: funcgraph_exit:         1.790 us   |                  }
           a.out-4609  [003]    50.323915: funcgraph_exit:         2.980 us   |                }
           a.out-4609  [003]    50.323916: funcgraph_entry:        0.640 us   |                stack_trace_consume_entry();
           a.out-4609  [003]    50.323917: funcgraph_entry:                   |                unwind_next_frame() {
           a.out-4609  [003]    50.323918: funcgraph_entry:                   |                  update_stack_state() {
           a.out-4609  [003]    50.323919: funcgraph_entry:        0.620 us   |                    unwind_get_return_address_ptr();
           a.out-4609  [003]    50.323920: funcgraph_exit:         1.860 us   |                  }
           a.out-4609  [003]    50.323920: funcgraph_exit:         3.050 us   |                }
           a.out-4609  [003]    50.323921: funcgraph_entry:                   |                unwind_get_return_address() {
           a.out-4609  [003]    50.323922: funcgraph_entry:                   |                  __kernel_text_address() {
           a.out-4609  [003]    50.323922: funcgraph_entry:        0.600 us   |                    kernel_text_address();
           a.out-4609  [003]    50.323923: funcgraph_exit:         1.780 us   |                  }
           a.out-4609  [003]    50.323924: funcgraph_exit:         2.980 us   |                }
           a.out-4609  [003]    50.323924: funcgraph_entry:        0.630 us   |                stack_trace_consume_entry();
           a.out-4609  [003]    50.323926: funcgraph_entry:                   |                unwind_next_frame() {
           a.out-4609  [003]    50.323926: funcgraph_entry:                   |                  update_stack_state() {
           a.out-4609  [003]    50.323927: funcgraph_entry:        0.610 us   |                    unwind_get_return_address_ptr();
           a.out-4609  [003]    50.323928: funcgraph_exit:         1.850 us   |                  }
           a.out-4609  [003]    50.323929: funcgraph_exit:         3.050 us   |                }
           a.out-4609  [003]    50.323929: funcgraph_entry:                   |                unwind_get_return_address() {
           a.out-4609  [003]    50.323930: funcgraph_entry:                   |                  __kernel_text_address() {
           a.out-4609  [003]    50.323931: funcgraph_entry:        0.610 us   |                    kernel_text_address();
           a.out-4609  [003]    50.323932: funcgraph_exit:         1.780 us   |                  }
           a.out-4609  [003]    50.323932: funcgraph_exit:         2.980 us   |                }
           a.out-4609  [003]    50.323933: funcgraph_entry:        0.630 us   |                stack_trace_consume_entry();
           a.out-4609  [003]    50.323934: funcgraph_entry:                   |                unwind_next_frame() {
           a.out-4609  [003]    50.323935: funcgraph_entry:                   |                  update_stack_state() {
           a.out-4609  [003]    50.323935: funcgraph_entry:        0.620 us   |                    unwind_get_return_address_ptr();
           a.out-4609  [003]    50.323936: funcgraph_exit:         1.840 us   |                  }
           a.out-4609  [003]    50.323937: funcgraph_exit:         3.040 us   |                }
           a.out-4609  [003]    50.323938: funcgraph_entry:                   |                unwind_get_return_address() {
           a.out-4609  [003]    50.323938: funcgraph_entry:                   |                  __kernel_text_address() {
           a.out-4609  [003]    50.323939: funcgraph_entry:        0.610 us   |                    kernel_text_address();
           a.out-4609  [003]    50.323940: funcgraph_exit:         1.780 us   |                  }
           a.out-4609  [003]    50.323941: funcgraph_exit:         2.970 us   |                }
           a.out-4609  [003]    50.323941: funcgraph_entry:        0.630 us   |                stack_trace_consume_entry();
           a.out-4609  [003]    50.323942: funcgraph_entry:                   |                unwind_next_frame() {
           a.out-4609  [003]    50.323943: funcgraph_entry:                   |                  update_stack_state() {
           a.out-4609  [003]    50.323944: funcgraph_entry:        0.620 us   |                    unwind_get_return_address_ptr();
           a.out-4609  [003]    50.323945: funcgraph_exit:         1.840 us   |                  }
           a.out-4609  [003]    50.323945: funcgraph_exit:         3.050 us   |                }
           a.out-4609  [003]    50.323946: funcgraph_entry:                   |                unwind_get_return_address() {
           a.out-4609  [003]    50.323947: funcgraph_entry:                   |                  __kernel_text_address() {
           a.out-4609  [003]    50.323947: funcgraph_entry:        0.600 us   |                    kernel_text_address();
           a.out-4609  [003]    50.323948: funcgraph_exit:         1.780 us   |                  }
           a.out-4609  [003]    50.323949: funcgraph_exit:         2.970 us   |                }
           a.out-4609  [003]    50.323950: funcgraph_entry:        0.630 us   |                stack_trace_consume_entry();
           a.out-4609  [003]    50.323951: funcgraph_entry:                   |                unwind_next_frame() {
           a.out-4609  [003]    50.323951: funcgraph_entry:                   |                  update_stack_state() {
           a.out-4609  [003]    50.323952: funcgraph_entry:        0.620 us   |                    unwind_get_return_address_ptr();
           a.out-4609  [003]    50.323953: funcgraph_exit:         1.880 us   |                  }
           a.out-4609  [003]    50.323954: funcgraph_exit:         3.080 us   |                }
           a.out-4609  [003]    50.323954: funcgraph_entry:                   |                unwind_get_return_address() {
           a.out-4609  [003]    50.323955: funcgraph_entry:                   |                  __kernel_text_address() {
           a.out-4609  [003]    50.323956: funcgraph_entry:        0.610 us   |                    kernel_text_address();
           a.out-4609  [003]    50.323957: funcgraph_exit:         1.790 us   |                  }
           a.out-4609  [003]    50.323957: funcgraph_exit:         2.980 us   |                }
           a.out-4609  [003]    50.323958: funcgraph_entry:        0.630 us   |                stack_trace_consume_entry();
           a.out-4609  [003]    50.323959: funcgraph_entry:                   |                unwind_next_frame() {
           a.out-4609  [003]    50.323960: funcgraph_entry:                   |                  update_stack_state() {
           a.out-4609  [003]    50.323960: funcgraph_entry:        0.620 us   |                    unwind_get_return_address_ptr();
           a.out-4609  [003]    50.323962: funcgraph_exit:         1.880 us   |                  }
           a.out-4609  [003]    50.323963: funcgraph_exit:         3.080 us   |                }
           a.out-4609  [003]    50.323969: funcgraph_entry:                   |                irq_enter_rcu() {
           a.out-4609  [003]    50.323969: funcgraph_entry:        0.620 us   |                  preempt_count_add();
           a.out-4609  [003]    50.323971: funcgraph_exit:         1.900 us   |                }
           a.out-4609  [003]    50.323971: funcgraph_entry:                   |                __sysvec_irq_work() {
           a.out-4609  [003]    50.323972: funcgraph_entry:                   |                  __wake_up() {
           a.out-4609  [003]    50.323973: funcgraph_entry:                   |                    __wake_up_common_lock() {
           a.out-4609  [003]    50.323973: funcgraph_entry:                   |                      _raw_spin_lock_irqsave() {
           a.out-4609  [003]    50.323974: funcgraph_entry:        0.590 us   |                        preempt_count_add();
           a.out-4609  [003]    50.323975: funcgraph_exit:         1.760 us   |                      }
           a.out-4609  [003]    50.323975: funcgraph_entry:        0.610 us   |                      __wake_up_common();
           a.out-4609  [003]    50.323977: funcgraph_entry:                   |                      _raw_spin_unlock_irqrestore() {
           a.out-4609  [003]    50.323977: funcgraph_entry:        0.650 us   |                        preempt_count_sub();
           a.out-4609  [003]    50.323978: funcgraph_exit:         1.800 us   |                      }
           a.out-4609  [003]    50.323979: funcgraph_exit:         6.430 us   |                    }
           a.out-4609  [003]    50.323979: funcgraph_exit:         7.570 us   |                  }
           a.out-4609  [003]    50.323980: funcgraph_entry:                   |                  __wake_up() {
           a.out-4609  [003]    50.323981: funcgraph_entry:                   |                    __wake_up_common_lock() {
           a.out-4609  [003]    50.323981: funcgraph_entry:                   |                      _raw_spin_lock_irqsave() {
           a.out-4609  [003]    50.323982: funcgraph_entry:        0.590 us   |                        preempt_count_add();
           a.out-4609  [003]    50.323983: funcgraph_exit:         1.750 us   |                      }
           a.out-4609  [003]    50.323984: funcgraph_entry:                   |                      __wake_up_common() {
           a.out-4609  [003]    50.323984: funcgraph_entry:                   |                        autoremove_wake_function() {
           a.out-4609  [003]    50.323985: funcgraph_entry:                   |                          default_wake_function() {
           a.out-4609  [003]    50.323986: funcgraph_entry:                   |                            try_to_wake_up() {
           a.out-4609  [003]    50.323986: funcgraph_entry:        0.590 us   |                              preempt_count_add();
           a.out-4609  [003]    50.323987: funcgraph_entry:                   |                              _raw_spin_lock_irqsave() {
           a.out-4609  [003]    50.323988: funcgraph_entry:        0.590 us   |                                preempt_count_add();
           a.out-4609  [003]    50.323989: funcgraph_exit:         1.780 us   |                              }
           a.out-4609  [003]    50.323990: funcgraph_entry:                   |                              __traceiter_sched_waking() {
           a.out-4609  [003]    50.323990: funcgraph_entry:                   |                                _raw_spin_lock_irqsave() {
           a.out-4609  [003]    50.323991: funcgraph_entry:        0.580 us   |                                  preempt_count_add();
           a.out-4609  [003]    50.323992: funcgraph_exit:         1.820 us   |                                }
           a.out-4609  [003]    50.323993: funcgraph_entry:                   |                                _raw_spin_unlock_irqrestore() {
           a.out-4609  [003]    50.323993: funcgraph_entry:        0.590 us   |                                  preempt_count_sub();
           a.out-4609  [003]    50.323994: funcgraph_exit:         1.740 us   |                                }
           a.out-4609  [003]    50.323995: funcgraph_exit:         5.380 us   |                              }
           a.out-4609  [003]    50.323996: funcgraph_entry:                   |                              select_task_rq_fair() {
           a.out-4609  [003]    50.323996: funcgraph_entry:        0.590 us   |                                __rcu_read_lock();
           a.out-4609  [003]    50.323998: funcgraph_entry:                   |                                available_idle_cpu() {
           a.out-4609  [003]    50.323998: funcgraph_entry:        0.690 us   |                                  idle_cpu();
           a.out-4609  [003]    50.323999: funcgraph_exit:         1.840 us   |                                }
           a.out-4609  [003]    50.324000: funcgraph_entry:        0.600 us   |                                __rcu_read_unlock();
           a.out-4609  [003]    50.324001: funcgraph_exit:         5.410 us   |                              }
           a.out-4609  [003]    50.324002: funcgraph_entry:                   |                              ttwu_queue_wakelist() {
           a.out-4609  [003]    50.324002: funcgraph_entry:        0.620 us   |                                cpus_share_cache();
           a.out-4609  [003]    50.324004: funcgraph_entry:                   |                                __smp_call_single_queue() {
           a.out-4609  [003]    50.324004: funcgraph_entry:        0.610 us   |                                  call_function_single_prep_ipi();
           a.out-4609  [003]    50.324005: funcgraph_entry:                   |                                  native_send_call_func_single_ipi() {
           a.out-4609  [003]    50.324006: funcgraph_entry:                   |                                    x2apic_send_IPI() {
           a.out-4609  [003]    50.324007: funcgraph_entry:        2.610 us   |                                      __x2apic_send_IPI_dest();
           a.out-4609  [003]    50.324010: funcgraph_exit:         3.850 us   |                                    }
           a.out-4609  [003]    50.324010: funcgraph_exit:         5.010 us   |                                  }
           a.out-4609  [003]    50.324011: funcgraph_exit:         7.360 us   |                                }
           a.out-4609  [003]    50.324011: funcgraph_exit:         9.840 us   |                              }
           a.out-4609  [003]    50.324012: funcgraph_entry:                   |                              _raw_spin_unlock_irqrestore() {
           a.out-4609  [003]    50.324013: funcgraph_entry:        0.580 us   |                                preempt_count_sub();
           a.out-4609  [003]    50.324014: funcgraph_exit:         1.750 us   |                              }
           a.out-4609  [003]    50.324014: funcgraph_entry:        0.590 us   |                              preempt_count_sub();
           a.out-4609  [003]    50.324015: funcgraph_exit:       + 30.030 us  |                            }
           a.out-4609  [003]    50.324016: funcgraph_exit:       + 31.180 us  |                          }
           a.out-4609  [003]    50.324017: funcgraph_exit:       + 32.350 us  |                        }
           a.out-4609  [003]    50.324017: funcgraph_exit:       + 33.610 us  |                      }
           a.out-4609  [003]    50.324018: funcgraph_entry:                   |                      _raw_spin_unlock_irqrestore() {
           a.out-4609  [003]    50.324018: funcgraph_entry:        0.590 us   |                        preempt_count_sub();
           a.out-4609  [003]    50.324019: funcgraph_exit:         1.740 us   |                      }
           a.out-4609  [003]    50.324020: funcgraph_exit:       + 39.330 us  |                    }
           a.out-4609  [003]    50.324021: funcgraph_exit:       + 40.480 us  |                  }
           a.out-4609  [003]    50.324021: funcgraph_exit:       + 50.120 us  |                }
           a.out-4609  [003]    50.324022: funcgraph_entry:                   |                irq_exit_rcu() {
           a.out-4609  [003]    50.324022: funcgraph_entry:        0.620 us   |                  preempt_count_sub();
           a.out-4609  [003]    50.324024: funcgraph_entry:        0.610 us   |                  idle_cpu();
           a.out-4609  [003]    50.324025: funcgraph_exit:         2.940 us   |                }
           a.out-4609  [003]    50.324025: funcgraph_entry:                   |                unwind_get_return_address() {
           a.out-4609  [003]    50.324026: funcgraph_entry:                   |                  __kernel_text_address() {
           a.out-4609  [003]    50.324027: funcgraph_entry:        0.610 us   |                    kernel_text_address();
           a.out-4609  [003]    50.324028: funcgraph_exit:         1.800 us   |                  }
           a.out-4609  [003]    50.324028: funcgraph_exit:         3.000 us   |                }
           a.out-4609  [003]    50.324029: funcgraph_entry:        0.630 us   |                stack_trace_consume_entry();
           a.out-4609  [003]    50.324030: funcgraph_entry:                   |                unwind_next_frame() {
           a.out-4609  [003]    50.324031: funcgraph_entry:                   |                  update_stack_state() {
           a.out-4609  [003]    50.324031: funcgraph_entry:        0.620 us   |                    unwind_get_return_address_ptr();
           a.out-4609  [003]    50.324033: funcgraph_exit:         1.910 us   |                  }
           a.out-4609  [003]    50.324033: funcgraph_exit:         3.110 us   |                }
           a.out-4609  [003]    50.324034: funcgraph_entry:                   |                unwind_get_return_address() {
           a.out-4609  [003]    50.324034: funcgraph_entry:                   |                  __kernel_text_address() {
           a.out-4609  [003]    50.324035: funcgraph_entry:        0.610 us   |                    kernel_text_address();
           a.out-4609  [003]    50.324036: funcgraph_exit:         1.770 us   |                  }
           a.out-4609  [003]    50.324037: funcgraph_exit:         2.960 us   |                }
           a.out-4609  [003]    50.324037: funcgraph_entry:        0.620 us   |                stack_trace_consume_entry();
           a.out-4609  [003]    50.324039: funcgraph_entry:                   |                unwind_next_frame() {
           a.out-4609  [003]    50.324039: funcgraph_entry:                   |                  update_stack_state() {
           a.out-4609  [003]    50.324040: funcgraph_entry:        0.610 us   |                    unwind_get_return_address_ptr();
           a.out-4609  [003]    50.324041: funcgraph_exit:         1.850 us   |                  }
           a.out-4609  [003]    50.324042: funcgraph_exit:         3.050 us   |                }
           a.out-4609  [003]    50.324043: funcgraph_entry:                   |                unwind_get_return_address() {
           a.out-4609  [003]    50.324044: funcgraph_entry:                   |                  __kernel_text_address() {
           a.out-4609  [003]    50.324044: funcgraph_entry:        0.600 us   |                    kernel_text_address();
           a.out-4609  [003]    50.324046: funcgraph_exit:         1.780 us   |                  }
           a.out-4609  [003]    50.324046: funcgraph_exit:         2.970 us   |                }
           a.out-4609  [003]    50.324047: funcgraph_entry:        0.630 us   |                stack_trace_consume_entry();
           a.out-4609  [003]    50.324048: funcgraph_entry:                   |                unwind_next_frame() {
           a.out-4609  [003]    50.324049: funcgraph_entry:                   |                  update_stack_state() {
           a.out-4609  [003]    50.324049: funcgraph_entry:        0.610 us   |                    unwind_get_return_address_ptr();
           a.out-4609  [003]    50.324050: funcgraph_exit:         1.900 us   |                  }
           a.out-4609  [003]    50.324051: funcgraph_exit:         3.090 us   |                }
           a.out-4609  [003]    50.324052: funcgraph_entry:                   |                unwind_get_return_address() {
           a.out-4609  [003]    50.324052: funcgraph_entry:                   |                  __kernel_text_address() {
           a.out-4609  [003]    50.324053: funcgraph_entry:        0.610 us   |                    kernel_text_address();
           a.out-4609  [003]    50.324054: funcgraph_exit:         1.780 us   |                  }
           a.out-4609  [003]    50.324055: funcgraph_exit:         2.950 us   |                }
           a.out-4609  [003]    50.324055: funcgraph_entry:        0.620 us   |                stack_trace_consume_entry();
           a.out-4609  [003]    50.324056: funcgraph_entry:                   |                unwind_next_frame() {
           a.out-4609  [003]    50.324057: funcgraph_entry:                   |                  update_stack_state() {
           a.out-4609  [003]    50.324058: funcgraph_entry:        0.610 us   |                    unwind_get_return_address_ptr();
           a.out-4609  [003]    50.324059: funcgraph_exit:         1.840 us   |                  }
           a.out-4609  [003]    50.324059: funcgraph_exit:         3.030 us   |                }
           a.out-4609  [003]    50.324060: funcgraph_entry:                   |                unwind_get_return_address() {
           a.out-4609  [003]    50.324061: funcgraph_entry:                   |                  __kernel_text_address() {
           a.out-4609  [003]    50.324061: funcgraph_entry:        0.600 us   |                    kernel_text_address();
           a.out-4609  [003]    50.324062: funcgraph_exit:         1.780 us   |                  }
           a.out-4609  [003]    50.324063: funcgraph_exit:         2.960 us   |                }
           a.out-4609  [003]    50.324063: funcgraph_entry:        0.630 us   |                stack_trace_consume_entry();
           a.out-4609  [003]    50.324065: funcgraph_entry:                   |                unwind_next_frame() {
           a.out-4609  [003]    50.324065: funcgraph_entry:                   |                  update_stack_state() {
           a.out-4609  [003]    50.324066: funcgraph_entry:        0.610 us   |                    unwind_get_return_address_ptr();
           a.out-4609  [003]    50.324067: funcgraph_exit:         1.830 us   |                  }
           a.out-4609  [003]    50.324068: funcgraph_exit:         3.030 us   |                }
           a.out-4609  [003]    50.324068: funcgraph_entry:                   |                unwind_get_return_address() {
           a.out-4609  [003]    50.324069: funcgraph_entry:                   |                  __kernel_text_address() {
           a.out-4609  [003]    50.324069: funcgraph_entry:        0.610 us   |                    kernel_text_address();
           a.out-4609  [003]    50.324071: funcgraph_exit:         1.780 us   |                  }
           a.out-4609  [003]    50.324071: funcgraph_exit:         2.950 us   |                }
           a.out-4609  [003]    50.324072: funcgraph_entry:        0.620 us   |                stack_trace_consume_entry();
           a.out-4609  [003]    50.324073: funcgraph_entry:                   |                unwind_next_frame() {
           a.out-4609  [003]    50.324074: funcgraph_entry:                   |                  update_stack_state() {
           a.out-4609  [003]    50.324074: funcgraph_entry:        0.610 us   |                    unwind_get_return_address_ptr();
           a.out-4609  [003]    50.324075: funcgraph_exit:         1.830 us   |                  }
           a.out-4609  [003]    50.324076: funcgraph_exit:         3.030 us   |                }
           a.out-4609  [003]    50.324077: funcgraph_entry:                   |                unwind_get_return_address() {
           a.out-4609  [003]    50.324077: funcgraph_entry:                   |                  __kernel_text_address() {
           a.out-4609  [003]    50.324078: funcgraph_entry:        0.610 us   |                    kernel_text_address();
           a.out-4609  [003]    50.324079: funcgraph_exit:         1.770 us   |                  }
           a.out-4609  [003]    50.324080: funcgraph_exit:         3.000 us   |                }
           a.out-4609  [003]    50.324080: funcgraph_entry:        0.780 us   |                stack_trace_consume_entry();
           a.out-4609  [003]    50.324082: funcgraph_entry:                   |                unwind_next_frame() {
           a.out-4609  [003]    50.324083: funcgraph_entry:                   |                  update_stack_state() {
           a.out-4609  [003]    50.324083: funcgraph_entry:        0.770 us   |                    unwind_get_return_address_ptr();
           a.out-4609  [003]    50.324085: funcgraph_exit:         2.290 us   |                  }
           a.out-4609  [003]    50.324086: funcgraph_exit:         3.800 us   |                }
           a.out-4609  [003]    50.324086: funcgraph_entry:                   |                unwind_get_return_address() {
           a.out-4609  [003]    50.324087: funcgraph_entry:                   |                  __kernel_text_address() {
           a.out-4609  [003]    50.324088: funcgraph_entry:        0.760 us   |                    kernel_text_address();
           a.out-4609  [003]    50.324089: funcgraph_exit:         2.230 us   |                  }
           a.out-4609  [003]    50.324090: funcgraph_exit:         3.710 us   |                }
           a.out-4609  [003]    50.324091: funcgraph_entry:        0.790 us   |                stack_trace_consume_entry();
           a.out-4609  [003]    50.324092: funcgraph_entry:                   |                unwind_next_frame() {
           a.out-4609  [003]    50.324093: funcgraph_entry:                   |                  update_stack_state() {
           a.out-4609  [003]    50.324093: funcgraph_entry:        0.660 us   |                    unwind_get_return_address_ptr();
           a.out-4609  [003]    50.324095: funcgraph_exit:         2.040 us   |                  }
           a.out-4609  [003]    50.324095: funcgraph_exit:         3.360 us   |                }
           a.out-4609  [003]    50.324096: funcgraph_entry:                   |                unwind_get_return_address() {
           a.out-4609  [003]    50.324097: funcgraph_entry:                   |                  __kernel_text_address() {
           a.out-4609  [003]    50.324097: funcgraph_entry:        0.610 us   |                    kernel_text_address();
           a.out-4609  [003]    50.324098: funcgraph_exit:         1.780 us   |                  }
           a.out-4609  [003]    50.324099: funcgraph_exit:         2.970 us   |                }
           a.out-4609  [003]    50.324100: funcgraph_entry:        0.630 us   |                stack_trace_consume_entry();
           a.out-4609  [003]    50.324101: funcgraph_entry:        0.800 us   |                unwind_next_frame();
           a.out-4609  [003]    50.324102: funcgraph_entry:                   |                unwind_get_return_address() {
           a.out-4609  [003]    50.324103: funcgraph_entry:                   |                  __kernel_text_address() {
           a.out-4609  [003]    50.324104: funcgraph_entry:                   |                    kernel_text_address() {
           a.out-4609  [003]    50.324105: funcgraph_entry:        0.750 us   |                      in_gate_area_no_mm();
           a.out-4609  [003]    50.324106: funcgraph_entry:                   |                      is_module_text_address() {
           a.out-4609  [003]    50.324107: funcgraph_entry:        0.790 us   |                        preempt_count_add();
           a.out-4609  [003]    50.324108: funcgraph_entry:                   |                        __module_text_address() {
           a.out-4609  [003]    50.324109: funcgraph_entry:        0.760 us   |                          __module_address();
           a.out-4609  [003]    50.324111: funcgraph_exit:         2.250 us   |                        }
           a.out-4609  [003]    50.324111: funcgraph_entry:        0.780 us   |                        preempt_count_sub();
           a.out-4609  [003]    50.324113: funcgraph_exit:         6.730 us   |                      }
           a.out-4609  [003]    50.324113: funcgraph_entry:                   |                      __is_insn_slot_addr() {
           a.out-4609  [003]    50.324114: funcgraph_entry:        0.610 us   |                        __rcu_read_lock();
           a.out-4609  [003]    50.324115: funcgraph_entry:        0.630 us   |                        __rcu_read_unlock();
           a.out-4609  [003]    50.324116: funcgraph_exit:         3.000 us   |                      }
           a.out-4609  [003]    50.324117: funcgraph_entry:                   |                      __is_insn_slot_addr() {
           a.out-4609  [003]    50.324118: funcgraph_entry:        0.610 us   |                        __rcu_read_lock();
           a.out-4609  [003]    50.324119: funcgraph_entry:        0.650 us   |                        __rcu_read_unlock();
           a.out-4609  [003]    50.324121: funcgraph_exit:         3.890 us   |                      }
           a.out-4609  [003]    50.324122: funcgraph_exit:       + 17.810 us  |                    }
           a.out-4609  [003]    50.324122: funcgraph_exit:       + 19.290 us  |                  }
           a.out-4609  [003]    50.324123: funcgraph_exit:       + 20.760 us  |                }
           a.out-4609  [003]    50.324124: funcgraph_exit:       ! 228.940 us |              }
           a.out-4609  [003]    50.324124: funcgraph_exit:       ! 230.260 us |            }
           a.out-4609  [003]    50.324125: funcgraph_entry:        0.850 us   |            filter_irq_stacks();
           a.out-4609  [003]    50.324127: funcgraph_entry:                   |            _raw_spin_lock_irqsave() {
           a.out-4609  [003]    50.324128: funcgraph_entry:        0.770 us   |              preempt_count_add();
           a.out-4609  [003]    50.324129: funcgraph_exit:         2.300 us   |            }
           a.out-4609  [003]    50.324130: funcgraph_entry:                   |            _raw_spin_unlock_irqrestore() {
           a.out-4609  [003]    50.324131: funcgraph_entry:        0.760 us   |              preempt_count_sub();
           a.out-4609  [003]    50.324132: funcgraph_exit:         2.120 us   |            }
           a.out-4609  [003]    50.324133: funcgraph_exit:       ! 241.980 us |          }
           a.out-4609  [003]    50.324133: funcgraph_entry:                   |          kmalloc_reserve() {
           a.out-4609  [003]    50.324134: funcgraph_entry:        0.610 us   |            kmalloc_size_roundup();
           a.out-4609  [003]    50.324135: funcgraph_entry:                   |            __kmalloc_node_track_caller() {
           a.out-4609  [003]    50.324136: funcgraph_entry:                   |              __kmalloc_large_node() {
           a.out-4609  [003]    50.324136: funcgraph_entry:                   |                __alloc_pages() {
           a.out-4609  [003]    50.324137: funcgraph_entry:        0.610 us   |                  __cond_resched();
           a.out-4609  [003]    50.324138: funcgraph_entry:        0.610 us   |                  should_fail_alloc_page();
           a.out-4609  [003]    50.324139: funcgraph_entry:                   |                  get_page_from_freelist() {
           a.out-4609  [003]    50.324140: funcgraph_entry:        0.620 us   |                    __zone_watermark_ok();
           a.out-4609  [003]    50.324141: funcgraph_entry:                   |                    _raw_spin_lock_irqsave() {
           a.out-4609  [003]    50.324142: funcgraph_entry:        0.620 us   |                      preempt_count_add();
           a.out-4609  [003]    50.324143: funcgraph_exit:         1.820 us   |                    }
           a.out-4609  [003]    50.324144: funcgraph_entry:        0.620 us   |                    __mod_zone_page_state();
           a.out-4609  [003]    50.324145: funcgraph_entry:                   |                    _raw_spin_unlock_irqrestore() {
           a.out-4609  [003]    50.324146: funcgraph_entry:        0.620 us   |                      preempt_count_sub();
           a.out-4609  [003]    50.324147: funcgraph_exit:         1.820 us   |                    }
           a.out-4609  [003]    50.324148: funcgraph_entry:                   |                    prep_new_page() {
           a.out-4609  [003]    50.324149: funcgraph_entry:        0.870 us   |                      prep_compound_page();
           a.out-4609  [003]    50.324150: funcgraph_exit:         2.790 us   |                    }
           a.out-4609  [003]    50.324151: funcgraph_exit:       + 11.640 us  |                  }
           a.out-4609  [003]    50.324152: funcgraph_exit:       + 15.240 us  |                }
           a.out-4609  [003]    50.324152: funcgraph_entry:        0.620 us   |                mod_node_page_state();
           a.out-4609  [003]    50.324153: funcgraph_exit:       + 17.690 us  |              }
           a.out-4609  [003]    50.324154: funcgraph_exit:       + 18.890 us  |            }
           a.out-4609  [003]    50.324155: funcgraph_exit:       + 21.300 us  |          }
           a.out-4609  [003]    50.324155: funcgraph_entry:        0.730 us   |          __build_skb_around();
           a.out-4609  [003]    50.324157: funcgraph_exit:       ! 266.560 us |        }
           a.out-4609  [003]    50.324157: funcgraph_exit:       ! 267.770 us |      }
           a.out-4609  [003]    50.324158: funcgraph_entry:        0.690 us   |      skb_set_owner_w();
           a.out-4609  [003]    50.324159: funcgraph_exit:       ! 270.390 us |    }
           a.out-4609  [003]    50.324160: funcgraph_entry:        0.630 us   |    skb_put();
           a.out-4609  [003]    50.324161: funcgraph_entry:                   |    skb_copy_datagram_from_iter() {
           a.out-4609  [003]    50.324163: funcgraph_entry:        0.620 us   |      fault_in_kernel_space();
           a.out-4609  [003]    50.324164: funcgraph_entry:                   |      lock_mm_and_find_vma() {
           a.out-4609  [003]    50.324165: funcgraph_entry:                   |        down_read_trylock() {
           a.out-4609  [003]    50.324166: funcgraph_entry:        0.620 us   |          preempt_count_add();
           a.out-4609  [003]    50.324167: funcgraph_entry:        0.630 us   |          preempt_count_sub();
           a.out-4609  [003]    50.324168: funcgraph_exit:         3.060 us   |        }
           a.out-4609  [003]    50.324169: funcgraph_entry:        0.610 us   |        __cond_resched();
           a.out-4609  [003]    50.324170: funcgraph_entry:                   |        find_vma() {
           a.out-4609  [003]    50.324170: funcgraph_entry:        0.620 us   |          __rcu_read_lock();
           a.out-4609  [003]    50.324172: funcgraph_entry:        0.630 us   |          __rcu_read_unlock();
           a.out-4609  [003]    50.324173: funcgraph_exit:         3.170 us   |        }
           a.out-4609  [003]    50.324174: funcgraph_exit:         9.230 us   |      }
           a.out-4609  [003]    50.324174: funcgraph_entry:                   |      handle_mm_fault() {
           a.out-4609  [003]    50.324175: funcgraph_entry:                   |        __handle_mm_fault() {
           a.out-4609  [003]    50.324176: funcgraph_entry:                   |          pte_offset_map_nolock() {
           a.out-4609  [003]    50.324176: funcgraph_entry:        0.620 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324177: funcgraph_exit:         1.830 us   |          }
           a.out-4609  [003]    50.324178: funcgraph_entry:                   |          __pte_offset_map_lock() {
           a.out-4609  [003]    50.324179: funcgraph_entry:        0.620 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324180: funcgraph_entry:                   |            _raw_spin_lock() {
           a.out-4609  [003]    50.324181: funcgraph_entry:        0.620 us   |              preempt_count_add();
           a.out-4609  [003]    50.324182: funcgraph_exit:         1.830 us   |            }
           a.out-4609  [003]    50.324182: funcgraph_exit:         4.200 us   |          }
           a.out-4609  [003]    50.324183: funcgraph_entry:        0.650 us   |          vmf_pte_changed();
           a.out-4609  [003]    50.324184: funcgraph_entry:                   |          _raw_spin_unlock() {
           a.out-4609  [003]    50.324185: funcgraph_entry:        0.620 us   |            preempt_count_sub();
           a.out-4609  [003]    50.324186: funcgraph_exit:         1.810 us   |          }
           a.out-4609  [003]    50.324186: funcgraph_exit:       + 11.620 us  |        }
           a.out-4609  [003]    50.324187: funcgraph_exit:       + 12.890 us  |      }
           a.out-4609  [003]    50.324188: funcgraph_entry:                   |      up_read() {
           a.out-4609  [003]    50.324188: funcgraph_entry:        0.620 us   |        preempt_count_add();
           a.out-4609  [003]    50.324189: funcgraph_entry:        0.620 us   |        preempt_count_sub();
           a.out-4609  [003]    50.324191: funcgraph_exit:         2.990 us   |      }
           a.out-4609  [003]    50.324192: funcgraph_entry:        0.610 us   |      fault_in_kernel_space();
           a.out-4609  [003]    50.324193: funcgraph_entry:                   |      lock_mm_and_find_vma() {
           a.out-4609  [003]    50.324194: funcgraph_entry:                   |        down_read_trylock() {
           a.out-4609  [003]    50.324194: funcgraph_entry:        0.620 us   |          preempt_count_add();
           a.out-4609  [003]    50.324196: funcgraph_entry:        0.620 us   |          preempt_count_sub();
           a.out-4609  [003]    50.324197: funcgraph_exit:         3.020 us   |        }
           a.out-4609  [003]    50.324198: funcgraph_entry:        1.190 us   |        __cond_resched();
           a.out-4609  [003]    50.324199: funcgraph_entry:                   |        find_vma() {
           a.out-4609  [003]    50.324200: funcgraph_entry:        0.610 us   |          __rcu_read_lock();
           a.out-4609  [003]    50.324201: funcgraph_entry:        0.620 us   |          __rcu_read_unlock();
           a.out-4609  [003]    50.324202: funcgraph_exit:         3.090 us   |        }
           a.out-4609  [003]    50.324203: funcgraph_exit:         9.630 us   |      }
           a.out-4609  [003]    50.324203: funcgraph_entry:                   |      handle_mm_fault() {
           a.out-4609  [003]    50.324204: funcgraph_entry:                   |        __handle_mm_fault() {
           a.out-4609  [003]    50.324205: funcgraph_entry:                   |          pte_offset_map_nolock() {
           a.out-4609  [003]    50.324205: funcgraph_entry:        0.620 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324206: funcgraph_exit:         1.790 us   |          }
           a.out-4609  [003]    50.324207: funcgraph_entry:                   |          __pte_offset_map_lock() {
           a.out-4609  [003]    50.324208: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324209: funcgraph_entry:                   |            _raw_spin_lock() {
           a.out-4609  [003]    50.324209: funcgraph_entry:        0.610 us   |              preempt_count_add();
           a.out-4609  [003]    50.324211: funcgraph_exit:         1.820 us   |            }
           a.out-4609  [003]    50.324211: funcgraph_exit:         4.180 us   |          }
           a.out-4609  [003]    50.324212: funcgraph_entry:        0.620 us   |          vmf_pte_changed();
           a.out-4609  [003]    50.324213: funcgraph_entry:                   |          _raw_spin_unlock() {
           a.out-4609  [003]    50.324214: funcgraph_entry:        0.610 us   |            preempt_count_sub();
           a.out-4609  [003]    50.324215: funcgraph_exit:         1.800 us   |          }
           a.out-4609  [003]    50.324215: funcgraph_exit:       + 11.360 us  |        }
           a.out-4609  [003]    50.324216: funcgraph_exit:       + 12.570 us  |      }
           a.out-4609  [003]    50.324217: funcgraph_entry:                   |      up_read() {
           a.out-4609  [003]    50.324217: funcgraph_entry:        0.610 us   |        preempt_count_add();
           a.out-4609  [003]    50.324218: funcgraph_entry:        0.620 us   |        preempt_count_sub();
           a.out-4609  [003]    50.324219: funcgraph_exit:         2.990 us   |      }
           a.out-4609  [003]    50.324221: funcgraph_entry:        0.610 us   |      fault_in_kernel_space();
           a.out-4609  [003]    50.324222: funcgraph_entry:                   |      lock_mm_and_find_vma() {
           a.out-4609  [003]    50.324222: funcgraph_entry:                   |        down_read_trylock() {
           a.out-4609  [003]    50.324223: funcgraph_entry:        0.610 us   |          preempt_count_add();
           a.out-4609  [003]    50.324224: funcgraph_entry:        0.620 us   |          preempt_count_sub();
           a.out-4609  [003]    50.324225: funcgraph_exit:         3.020 us   |        }
           a.out-4609  [003]    50.324226: funcgraph_entry:        0.610 us   |        __cond_resched();
           a.out-4609  [003]    50.324227: funcgraph_entry:                   |        find_vma() {
           a.out-4609  [003]    50.324228: funcgraph_entry:        0.610 us   |          __rcu_read_lock();
           a.out-4609  [003]    50.324229: funcgraph_entry:        0.620 us   |          __rcu_read_unlock();
           a.out-4609  [003]    50.324230: funcgraph_exit:         3.080 us   |        }
           a.out-4609  [003]    50.324231: funcgraph_exit:         9.020 us   |      }
           a.out-4609  [003]    50.324231: funcgraph_entry:                   |      handle_mm_fault() {
           a.out-4609  [003]    50.324232: funcgraph_entry:                   |        __handle_mm_fault() {
           a.out-4609  [003]    50.324233: funcgraph_entry:                   |          pte_offset_map_nolock() {
           a.out-4609  [003]    50.324233: funcgraph_entry:        0.620 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324234: funcgraph_exit:         1.800 us   |          }
           a.out-4609  [003]    50.324235: funcgraph_entry:                   |          __pte_offset_map_lock() {
           a.out-4609  [003]    50.324236: funcgraph_entry:        0.620 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324237: funcgraph_entry:                   |            _raw_spin_lock() {
           a.out-4609  [003]    50.324237: funcgraph_entry:        0.610 us   |              preempt_count_add();
           a.out-4609  [003]    50.324239: funcgraph_exit:         1.800 us   |            }
           a.out-4609  [003]    50.324239: funcgraph_exit:         4.190 us   |          }
           a.out-4609  [003]    50.324240: funcgraph_entry:        0.630 us   |          vmf_pte_changed();
           a.out-4609  [003]    50.324241: funcgraph_entry:                   |          _raw_spin_unlock() {
           a.out-4609  [003]    50.324242: funcgraph_entry:        0.610 us   |            preempt_count_sub();
           a.out-4609  [003]    50.324243: funcgraph_exit:         1.800 us   |          }
           a.out-4609  [003]    50.324243: funcgraph_exit:       + 11.380 us  |        }
           a.out-4609  [003]    50.324244: funcgraph_exit:       + 12.580 us  |      }
           a.out-4609  [003]    50.324244: funcgraph_entry:                   |      up_read() {
           a.out-4609  [003]    50.324245: funcgraph_entry:        0.620 us   |        preempt_count_add();
           a.out-4609  [003]    50.324246: funcgraph_entry:        0.620 us   |        preempt_count_sub();
           a.out-4609  [003]    50.324247: funcgraph_exit:         3.000 us   |      }
           a.out-4609  [003]    50.324248: funcgraph_entry:        0.610 us   |      fault_in_kernel_space();
           a.out-4609  [003]    50.324250: funcgraph_entry:                   |      lock_mm_and_find_vma() {
           a.out-4609  [003]    50.324250: funcgraph_entry:                   |        down_read_trylock() {
           a.out-4609  [003]    50.324251: funcgraph_entry:        0.610 us   |          preempt_count_add();
           a.out-4609  [003]    50.324252: funcgraph_entry:        0.620 us   |          preempt_count_sub();
           a.out-4609  [003]    50.324253: funcgraph_exit:         3.010 us   |        }
           a.out-4609  [003]    50.324254: funcgraph_entry:        0.610 us   |        __cond_resched();
           a.out-4609  [003]    50.324255: funcgraph_entry:                   |        find_vma() {
           a.out-4609  [003]    50.324256: funcgraph_entry:        0.610 us   |          __rcu_read_lock();
           a.out-4609  [003]    50.324260: funcgraph_entry:                   |          irq_enter_rcu() {
           a.out-4609  [003]    50.324261: funcgraph_entry:        0.630 us   |            preempt_count_add();
           a.out-4609  [003]    50.324262: funcgraph_exit:         1.880 us   |          }
           a.out-4609  [003]    50.324263: funcgraph_entry:                   |          __sysvec_apic_timer_interrupt() {
           a.out-4609  [003]    50.324263: funcgraph_entry:                   |            hrtimer_interrupt() {
           a.out-4609  [003]    50.324264: funcgraph_entry:                   |              _raw_spin_lock_irqsave() {
           a.out-4609  [003]    50.324265: funcgraph_entry:        0.590 us   |                preempt_count_add();
           a.out-4609  [003]    50.324266: funcgraph_exit:         1.780 us   |              }
           a.out-4609  [003]    50.324266: funcgraph_entry:        0.750 us   |              ktime_get_update_offsets_now();
           a.out-4609  [003]    50.324268: funcgraph_entry:                   |              __hrtimer_run_queues() {
           a.out-4609  [003]    50.324268: funcgraph_entry:        0.610 us   |                __next_base();
           a.out-4609  [003]    50.324270: funcgraph_entry:        0.780 us   |                __remove_hrtimer();
           a.out-4609  [003]    50.324271: funcgraph_entry:                   |                _raw_spin_unlock_irqrestore() {
           a.out-4609  [003]    50.324272: funcgraph_entry:        0.600 us   |                  preempt_count_sub();
           a.out-4609  [003]    50.324273: funcgraph_exit:         1.740 us   |                }
           a.out-4609  [003]    50.324273: funcgraph_entry:                   |                tick_sched_timer() {
           a.out-4609  [003]    50.324274: funcgraph_entry:        0.630 us   |                  ktime_get();
           a.out-4609  [003]    50.324276: funcgraph_entry:        1.410 us   |                  tick_sched_do_timer();
           a.out-4609  [003]    50.324277: funcgraph_entry:                   |                  tick_sched_handle() {
           a.out-4609  [003]    50.324278: funcgraph_entry:                   |                    update_process_times() {
           a.out-4609  [003]    50.324278: funcgraph_entry:                   |                      account_process_tick() {
           a.out-4609  [003]    50.324279: funcgraph_entry:        0.600 us   |                        kvm_steal_clock();
           a.out-4609  [003]    50.324280: funcgraph_entry:        0.600 us   |                        account_steal_time();
           a.out-4609  [003]    50.324281: funcgraph_entry:                   |                        account_system_time() {
           a.out-4609  [003]    50.324282: funcgraph_entry:                   |                          account_system_index_time() {
           a.out-4609  [003]    50.324283: funcgraph_entry:        0.620 us   |                            cpuacct_account_field();
           a.out-4609  [003]    50.324284: funcgraph_entry:                   |                            __cgroup_account_cputime_field() {
           a.out-4609  [003]    50.324284: funcgraph_entry:        0.590 us   |                              preempt_count_add();
           a.out-4609  [003]    50.324286: funcgraph_entry:                   |                              cgroup_base_stat_cputime_account_end() {
           a.out-4609  [003]    50.324286: funcgraph_entry:        0.610 us   |                                cgroup_rstat_updated();
           a.out-4609  [003]    50.324287: funcgraph_entry:        0.600 us   |                                preempt_count_sub();
           a.out-4609  [003]    50.324288: funcgraph_exit:         2.930 us   |                              }
           a.out-4609  [003]    50.324289: funcgraph_exit:         5.240 us   |                            }
           a.out-4609  [003]    50.324290: funcgraph_entry:                   |                            acct_account_cputime() {
           a.out-4609  [003]    50.324290: funcgraph_entry:        0.640 us   |                              __acct_update_integrals();
           a.out-4609  [003]    50.324291: funcgraph_exit:         1.820 us   |                            }
           a.out-4609  [003]    50.324292: funcgraph_exit:       + 10.020 us  |                          }
           a.out-4609  [003]    50.324293: funcgraph_exit:       + 11.170 us  |                        }
           a.out-4609  [003]    50.324293: funcgraph_exit:       + 14.800 us  |                      }
           a.out-4609  [003]    50.324294: funcgraph_entry:        0.610 us   |                      hrtimer_run_queues();
           a.out-4609  [003]    50.324295: funcgraph_entry:                   |                      rcu_sched_clock_irq() {
           a.out-4609  [003]    50.324296: funcgraph_entry:        0.610 us   |                        rcu_stall_kick_kthreads();
           a.out-4609  [003]    50.324297: funcgraph_entry:        0.600 us   |                        rcu_is_cpu_rrupt_from_idle();
           a.out-4609  [003]    50.324298: funcgraph_entry:        0.610 us   |                        rcu_segcblist_ready_cbs();
           a.out-4609  [003]    50.324299: funcgraph_entry:                   |                        invoke_rcu_core() {
           a.out-4609  [003]    50.324300: funcgraph_entry:                   |                          raise_softirq() {
           a.out-4609  [003]    50.324300: funcgraph_entry:        0.590 us   |                            __raise_softirq_irqoff();
           a.out-4609  [003]    50.324301: funcgraph_exit:         1.750 us   |                          }
           a.out-4609  [003]    50.324302: funcgraph_exit:         2.910 us   |                        }
           a.out-4609  [003]    50.324303: funcgraph_entry:        0.600 us   |                        rcu_is_cpu_rrupt_from_idle();
           a.out-4609  [003]    50.324304: funcgraph_exit:         8.900 us   |                      }
           a.out-4609  [003]    50.324304: funcgraph_entry:                   |                      scheduler_tick() {
           a.out-4609  [003]    50.324305: funcgraph_entry:        0.590 us   |                        arch_scale_freq_tick();
           a.out-4609  [003]    50.324306: funcgraph_entry:                   |                        raw_spin_rq_lock_nested() {
           a.out-4609  [003]    50.324307: funcgraph_entry:        0.590 us   |                          preempt_count_add();
           a.out-4609  [003]    50.324308: funcgraph_entry:                   |                          _raw_spin_lock() {
           a.out-4609  [003]    50.324309: funcgraph_entry:        0.600 us   |                            preempt_count_add();
           a.out-4609  [003]    50.324310: funcgraph_exit:         1.870 us   |                          }
           a.out-4609  [003]    50.324310: funcgraph_entry:        0.600 us   |                          preempt_count_sub();
           a.out-4609  [003]    50.324311: funcgraph_exit:         5.320 us   |                        }
           a.out-4609  [003]    50.324312: funcgraph_entry:        0.710 us   |                        update_rq_clock();
           a.out-4609  [003]    50.324313: funcgraph_entry:                   |                        task_tick_fair() {
           a.out-4609  [003]    50.324314: funcgraph_entry:                   |                          update_curr() {
           a.out-4609  [003]    50.324315: funcgraph_entry:        0.690 us   |                            update_min_vruntime();
           a.out-4609  [003]    50.324316: funcgraph_entry:        0.640 us   |                            cpuacct_charge();
           a.out-4609  [003]    50.324317: funcgraph_entry:                   |                            __cgroup_account_cputime() {
           a.out-4609  [003]    50.324318: funcgraph_entry:        0.590 us   |                              preempt_count_add();
           a.out-4609  [003]    50.324319: funcgraph_entry:                   |                              cgroup_base_stat_cputime_account_end() {
           a.out-4609  [003]    50.324319: funcgraph_entry:        0.600 us   |                                cgroup_rstat_updated();
           a.out-4609  [003]    50.324321: funcgraph_entry:        0.590 us   |                                preempt_count_sub();
           a.out-4609  [003]    50.324322: funcgraph_exit:         2.900 us   |                              }
           a.out-4609  [003]    50.324322: funcgraph_exit:         5.200 us   |                            }
           a.out-4609  [003]    50.324323: funcgraph_exit:         8.890 us   |                          }
           a.out-4609  [003]    50.324323: funcgraph_entry:                   |                          __update_load_avg_se() {
           a.out-4609  [003]    50.324324: funcgraph_entry:        0.600 us   |                            decay_load();
           a.out-4609  [003]    50.324325: funcgraph_entry:        0.600 us   |                            decay_load();
           a.out-4609  [003]    50.324326: funcgraph_entry:        0.600 us   |                            decay_load();
           a.out-4609  [003]    50.324328: funcgraph_entry:                   |                            __accumulate_pelt_segments() {
           a.out-4609  [003]    50.324328: funcgraph_entry:        0.590 us   |                              decay_load();
           a.out-4609  [003]    50.324329: funcgraph_entry:        0.600 us   |                              decay_load();
           a.out-4609  [003]    50.324330: funcgraph_exit:         2.890 us   |                            }
           a.out-4609  [003]    50.324331: funcgraph_exit:         7.630 us   |                          }
           a.out-4609  [003]    50.324332: funcgraph_entry:                   |                          __update_load_avg_cfs_rq() {
           a.out-4609  [003]    50.324332: funcgraph_entry:        0.600 us   |                            decay_load();
           a.out-4609  [003]    50.324334: funcgraph_entry:        0.600 us   |                            decay_load();
           a.out-4609  [003]    50.324335: funcgraph_entry:        0.600 us   |                            decay_load();
           a.out-4609  [003]    50.324336: funcgraph_entry:                   |                            __accumulate_pelt_segments() {
           a.out-4609  [003]    50.324336: funcgraph_entry:        0.590 us   |                              decay_load();
           a.out-4609  [003]    50.324338: funcgraph_entry:        0.590 us   |                              decay_load();
           a.out-4609  [003]    50.324339: funcgraph_exit:         2.890 us   |                            }
           a.out-4609  [003]    50.324339: funcgraph_exit:         7.650 us   |                          }
           a.out-4609  [003]    50.324340: funcgraph_entry:        0.610 us   |                          update_cfs_group();
           a.out-4609  [003]    50.324341: funcgraph_entry:        0.640 us   |                          hrtimer_active();
           a.out-4609  [003]    50.324342: funcgraph_entry:                   |                          cpu_util_cfs() {
           a.out-4609  [003]    50.324343: funcgraph_entry:        0.680 us   |                            cpu_util();
           a.out-4609  [003]    50.324344: funcgraph_exit:         1.830 us   |                          }
           a.out-4609  [003]    50.324345: funcgraph_entry:        0.610 us   |                          capacity_of();
           a.out-4609  [003]    50.324346: funcgraph_exit:       + 32.650 us  |                        }
           a.out-4609  [003]    50.324347: funcgraph_entry:        0.610 us   |                        calc_global_load_tick();
           a.out-4609  [003]    50.324348: funcgraph_entry:        0.700 us   |                        task_tick_mm_cid();
           a.out-4609  [003]    50.324350: funcgraph_entry:                   |                        _raw_spin_unlock() {
           a.out-4609  [003]    50.324350: funcgraph_entry:        0.590 us   |                          preempt_count_sub();
           a.out-4609  [003]    50.324351: funcgraph_exit:         1.820 us   |                        }
           a.out-4609  [003]    50.324352: funcgraph_entry:                   |                        perf_event_task_tick() {
           a.out-4609  [003]    50.324353: funcgraph_entry:        0.590 us   |                          perf_adjust_freq_unthr_context();
           a.out-4609  [003]    50.324354: funcgraph_entry:        0.610 us   |                          __rcu_read_lock();
           a.out-4609  [003]    50.324355: funcgraph_entry:        0.610 us   |                          __rcu_read_unlock();
           a.out-4609  [003]    50.324356: funcgraph_exit:         4.110 us   |                        }
           a.out-4609  [003]    50.324357: funcgraph_entry:        0.610 us   |                        idle_cpu();
           a.out-4609  [003]    50.324358: funcgraph_entry:                   |                        trigger_load_balance() {
           a.out-4609  [003]    50.324359: funcgraph_entry:        0.600 us   |                          nohz_balance_exit_idle();
           a.out-4609  [003]    50.324360: funcgraph_entry:        0.600 us   |                          __rcu_read_lock();
           a.out-4609  [003]    50.324361: funcgraph_entry:        0.600 us   |                          __rcu_read_unlock();
           a.out-4609  [003]    50.324362: funcgraph_exit:         4.260 us   |                        }
           a.out-4609  [003]    50.324363: funcgraph_exit:       + 58.300 us  |                      }
           a.out-4609  [003]    50.324363: funcgraph_entry:        0.660 us   |                      run_posix_cpu_timers();
           a.out-4609  [003]    50.324364: funcgraph_exit:       + 86.760 us  |                    }
           a.out-4609  [003]    50.324365: funcgraph_entry:        0.650 us   |                    profile_tick();
           a.out-4609  [003]    50.324366: funcgraph_exit:       + 89.160 us  |                  }
           a.out-4609  [003]    50.324367: funcgraph_entry:                   |                  hrtimer_forward() {
           a.out-4609  [003]    50.324367: funcgraph_entry:        0.590 us   |                    ktime_add_safe();
           a.out-4609  [003]    50.324369: funcgraph_entry:        0.600 us   |                    ktime_add_safe();
           a.out-4609  [003]    50.324370: funcgraph_exit:         2.910 us   |                  }
           a.out-4609  [003]    50.324370: funcgraph_exit:       + 96.960 us  |                }
           a.out-4609  [003]    50.324371: funcgraph_entry:                   |                _raw_spin_lock_irq() {
           a.out-4609  [003]    50.324371: funcgraph_entry:        0.590 us   |                  preempt_count_add();
           a.out-4609  [003]    50.324373: funcgraph_exit:         1.770 us   |                }
           a.out-4609  [003]    50.324373: funcgraph_entry:        0.730 us   |                enqueue_hrtimer();
           a.out-4609  [003]    50.324374: funcgraph_entry:        0.610 us   |                __next_base();
           a.out-4609  [003]    50.324376: funcgraph_entry:        0.610 us   |                __next_base();
           a.out-4609  [003]    50.324377: funcgraph_exit:       ! 109.040 us |              }
           a.out-4609  [003]    50.324377: funcgraph_entry:                   |              hrtimer_update_next_event() {
           a.out-4609  [003]    50.324378: funcgraph_entry:                   |                __hrtimer_get_next_event() {
           a.out-4609  [003]    50.324379: funcgraph_entry:                   |                  __hrtimer_next_event_base() {
           a.out-4609  [003]    50.324379: funcgraph_entry:        0.600 us   |                    __next_base();
           a.out-4609  [003]    50.324380: funcgraph_exit:         1.740 us   |                  }
           a.out-4609  [003]    50.324381: funcgraph_exit:         2.910 us   |                }
           a.out-4609  [003]    50.324381: funcgraph_entry:                   |                __hrtimer_get_next_event() {
           a.out-4609  [003]    50.324382: funcgraph_entry:                   |                  __hrtimer_next_event_base() {
           a.out-4609  [003]    50.324383: funcgraph_entry:        0.600 us   |                    __next_base();
           a.out-4609  [003]    50.324384: funcgraph_entry:        0.610 us   |                    __next_base();
           a.out-4609  [003]    50.324385: funcgraph_entry:        0.600 us   |                    __next_base();
           a.out-4609  [003]    50.324386: funcgraph_exit:         4.120 us   |                  }
           a.out-4609  [003]    50.324387: funcgraph_exit:         5.280 us   |                }
           a.out-4609  [003]    50.324387: funcgraph_exit:         9.910 us   |              }
           a.out-4609  [003]    50.324388: funcgraph_entry:                   |              _raw_spin_unlock_irqrestore() {
           a.out-4609  [003]    50.324388: funcgraph_entry:        0.590 us   |                preempt_count_sub();
           a.out-4609  [003]    50.324390: funcgraph_exit:         1.740 us   |              }
           a.out-4609  [003]    50.324390: funcgraph_entry:                   |              tick_program_event() {
           a.out-4609  [003]    50.324391: funcgraph_entry:                   |                clockevents_program_event() {
           a.out-4609  [003]    50.324391: funcgraph_entry:        0.620 us   |                  ktime_get();
           a.out-4609  [003]    50.324393: funcgraph_entry:        2.450 us   |                  lapic_next_deadline();
           a.out-4609  [003]    50.324396: funcgraph_exit:         4.890 us   |                }
           a.out-4609  [003]    50.324396: funcgraph_exit:         6.050 us   |              }
           a.out-4609  [003]    50.324397: funcgraph_exit:       ! 133.360 us |            }
           a.out-4609  [003]    50.324397: funcgraph_exit:       ! 134.620 us |          }
           a.out-4609  [003]    50.324398: funcgraph_entry:                   |          irq_exit_rcu() {
           a.out-4609  [003]    50.324398: funcgraph_entry:        0.620 us   |            preempt_count_sub();
           a.out-4609  [003]    50.324400: funcgraph_entry:                   |            __do_softirq() {
           a.out-4609  [003]    50.324400: funcgraph_entry:        0.620 us   |              __local_bh_disable_ip();
           a.out-4609  [003]    50.324402: funcgraph_entry:                   |              rcu_core_si() {
           a.out-4609  [003]    50.324402: funcgraph_entry:                   |                rcu_core() {
           a.out-4609  [003]    50.324403: funcgraph_entry:                   |                  note_gp_changes() {
           a.out-4609  [003]    50.324404: funcgraph_entry:                   |                    _raw_spin_trylock() {
           a.out-4609  [003]    50.324407: funcgraph_entry:        0.610 us   |                      preempt_count_add();
           a.out-4609  [003]    50.324408: funcgraph_exit:         4.750 us   |                    }
           a.out-4609  [003]    50.324409: funcgraph_entry:                   |                    __note_gp_changes() {
           a.out-4609  [003]    50.324409: funcgraph_entry:                   |                      rcu_advance_cbs() {
           a.out-4609  [003]    50.324410: funcgraph_entry:        0.610 us   |                        rcu_segcblist_pend_cbs();
           a.out-4609  [003]    50.324411: funcgraph_exit:         1.770 us   |                      }
           a.out-4609  [003]    50.324412: funcgraph_entry:        0.620 us   |                      rcu_gpnum_ovf();
           a.out-4609  [003]    50.324413: funcgraph_exit:         4.270 us   |                    }
           a.out-4609  [003]    50.324414: funcgraph_entry:                   |                    _raw_spin_unlock_irqrestore() {
           a.out-4609  [003]    50.324414: funcgraph_entry:        0.630 us   |                      preempt_count_sub();
           a.out-4609  [003]    50.324416: funcgraph_exit:         1.830 us   |                    }
           a.out-4609  [003]    50.324416: funcgraph_exit:       + 13.240 us  |                  }
           a.out-4609  [003]    50.324417: funcgraph_entry:        0.640 us   |                  rcu_jiffies_till_stall_check();
           a.out-4609  [003]    50.324418: funcgraph_entry:        0.630 us   |                  rcu_segcblist_ready_cbs();
           a.out-4609  [003]    50.324419: funcgraph_exit:       + 16.960 us  |                }
           a.out-4609  [003]    50.324420: funcgraph_exit:       + 18.210 us  |              }
           a.out-4609  [003]    50.324420: funcgraph_entry:        0.630 us   |              __local_bh_enable();
           a.out-4609  [003]    50.324422: funcgraph_exit:       + 21.910 us  |            }
           a.out-4609  [003]    50.324422: funcgraph_entry:        0.610 us   |            idle_cpu();
           a.out-4609  [003]    50.324424: funcgraph_exit:       + 26.220 us  |          }
           a.out-4609  [003]    50.324425: funcgraph_entry:        0.650 us   |          __rcu_read_unlock();
           a.out-4609  [003]    50.324426: funcgraph_exit:       ! 171.100 us |        }
           a.out-4609  [003]    50.324427: funcgraph_exit:       ! 177.050 us |      }
           a.out-4609  [003]    50.324427: funcgraph_entry:                   |      handle_mm_fault() {
           a.out-4609  [003]    50.324428: funcgraph_entry:                   |        __handle_mm_fault() {
           a.out-4609  [003]    50.324429: funcgraph_entry:                   |          pte_offset_map_nolock() {
           a.out-4609  [003]    50.324429: funcgraph_entry:        0.620 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324430: funcgraph_exit:         1.810 us   |          }
           a.out-4609  [003]    50.324431: funcgraph_entry:                   |          __pte_offset_map_lock() {
           a.out-4609  [003]    50.324432: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324433: funcgraph_entry:                   |            _raw_spin_lock() {
           a.out-4609  [003]    50.324434: funcgraph_entry:        0.630 us   |              preempt_count_add();
           a.out-4609  [003]    50.324435: funcgraph_exit:         1.840 us   |            }
           a.out-4609  [003]    50.324435: funcgraph_exit:         4.200 us   |          }
           a.out-4609  [003]    50.324436: funcgraph_entry:        0.620 us   |          vmf_pte_changed();
           a.out-4609  [003]    50.324437: funcgraph_entry:                   |          _raw_spin_unlock() {
           a.out-4609  [003]    50.324438: funcgraph_entry:        0.620 us   |            preempt_count_sub();
           a.out-4609  [003]    50.324439: funcgraph_exit:         1.820 us   |          }
           a.out-4609  [003]    50.324439: funcgraph_exit:       + 11.460 us  |        }
           a.out-4609  [003]    50.324440: funcgraph_exit:       + 12.680 us  |      }
           a.out-4609  [003]    50.324441: funcgraph_entry:                   |      up_read() {
           a.out-4609  [003]    50.324441: funcgraph_entry:        0.620 us   |        preempt_count_add();
           a.out-4609  [003]    50.324442: funcgraph_entry:        0.620 us   |        preempt_count_sub();
           a.out-4609  [003]    50.324444: funcgraph_exit:         3.060 us   |      }
           a.out-4609  [003]    50.324445: funcgraph_entry:        0.620 us   |      fault_in_kernel_space();
           a.out-4609  [003]    50.324446: funcgraph_entry:                   |      lock_mm_and_find_vma() {
           a.out-4609  [003]    50.324447: funcgraph_entry:                   |        down_read_trylock() {
           a.out-4609  [003]    50.324447: funcgraph_entry:        0.620 us   |          preempt_count_add();
           a.out-4609  [003]    50.324448: funcgraph_entry:        0.620 us   |          preempt_count_sub();
           a.out-4609  [003]    50.324450: funcgraph_exit:         3.030 us   |        }
           a.out-4609  [003]    50.324450: funcgraph_entry:        0.620 us   |        __cond_resched();
           a.out-4609  [003]    50.324451: funcgraph_entry:                   |        find_vma() {
           a.out-4609  [003]    50.324452: funcgraph_entry:        0.620 us   |          __rcu_read_lock();
           a.out-4609  [003]    50.324453: funcgraph_entry:        0.620 us   |          __rcu_read_unlock();
           a.out-4609  [003]    50.324454: funcgraph_exit:         3.090 us   |        }
           a.out-4609  [003]    50.324455: funcgraph_exit:         9.060 us   |      }
           a.out-4609  [003]    50.324456: funcgraph_entry:                   |      handle_mm_fault() {
           a.out-4609  [003]    50.324456: funcgraph_entry:                   |        __handle_mm_fault() {
           a.out-4609  [003]    50.324457: funcgraph_entry:                   |          pte_offset_map_nolock() {
           a.out-4609  [003]    50.324458: funcgraph_entry:        0.620 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324459: funcgraph_exit:         1.810 us   |          }
           a.out-4609  [003]    50.324459: funcgraph_entry:                   |          __pte_offset_map_lock() {
           a.out-4609  [003]    50.324460: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324461: funcgraph_entry:                   |            _raw_spin_lock() {
           a.out-4609  [003]    50.324462: funcgraph_entry:        0.620 us   |              preempt_count_add();
           a.out-4609  [003]    50.324463: funcgraph_exit:         1.820 us   |            }
           a.out-4609  [003]    50.324463: funcgraph_exit:         4.190 us   |          }
           a.out-4609  [003]    50.324464: funcgraph_entry:        0.630 us   |          vmf_pte_changed();
           a.out-4609  [003]    50.324465: funcgraph_entry:                   |          _raw_spin_unlock() {
           a.out-4609  [003]    50.324466: funcgraph_entry:        0.620 us   |            preempt_count_sub();
           a.out-4609  [003]    50.324467: funcgraph_exit:         1.790 us   |          }
           a.out-4609  [003]    50.324468: funcgraph_exit:       + 11.390 us  |        }
           a.out-4609  [003]    50.324468: funcgraph_exit:       + 12.580 us  |      }
           a.out-4609  [003]    50.324469: funcgraph_entry:                   |      up_read() {
           a.out-4609  [003]    50.324469: funcgraph_entry:        0.610 us   |        preempt_count_add();
           a.out-4609  [003]    50.324471: funcgraph_entry:        0.620 us   |        preempt_count_sub();
           a.out-4609  [003]    50.324472: funcgraph_exit:         3.000 us   |      }
           a.out-4609  [003]    50.324473: funcgraph_entry:        0.610 us   |      fault_in_kernel_space();
           a.out-4609  [003]    50.324474: funcgraph_entry:                   |      lock_mm_and_find_vma() {
           a.out-4609  [003]    50.324475: funcgraph_entry:                   |        down_read_trylock() {
           a.out-4609  [003]    50.324475: funcgraph_entry:        0.620 us   |          preempt_count_add();
           a.out-4609  [003]    50.324476: funcgraph_entry:        0.620 us   |          preempt_count_sub();
           a.out-4609  [003]    50.324478: funcgraph_exit:         3.020 us   |        }
           a.out-4609  [003]    50.324478: funcgraph_entry:        0.610 us   |        __cond_resched();
           a.out-4609  [003]    50.324479: funcgraph_entry:                   |        find_vma() {
           a.out-4609  [003]    50.324480: funcgraph_entry:        0.620 us   |          __rcu_read_lock();
           a.out-4609  [003]    50.324481: funcgraph_entry:        0.630 us   |          __rcu_read_unlock();
           a.out-4609  [003]    50.324482: funcgraph_exit:         3.080 us   |        }
           a.out-4609  [003]    50.324483: funcgraph_exit:         9.030 us   |      }
           a.out-4609  [003]    50.324484: funcgraph_entry:                   |      handle_mm_fault() {
           a.out-4609  [003]    50.324484: funcgraph_entry:                   |        __handle_mm_fault() {
           a.out-4609  [003]    50.324485: funcgraph_entry:                   |          pte_offset_map_nolock() {
           a.out-4609  [003]    50.324486: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324487: funcgraph_exit:         1.800 us   |          }
           a.out-4609  [003]    50.324487: funcgraph_entry:                   |          __pte_offset_map_lock() {
           a.out-4609  [003]    50.324488: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324489: funcgraph_entry:                   |            _raw_spin_lock() {
           a.out-4609  [003]    50.324490: funcgraph_entry:        0.620 us   |              preempt_count_add();
           a.out-4609  [003]    50.324491: funcgraph_exit:         1.820 us   |            }
           a.out-4609  [003]    50.324491: funcgraph_exit:         4.180 us   |          }
           a.out-4609  [003]    50.324492: funcgraph_entry:        0.620 us   |          vmf_pte_changed();
           a.out-4609  [003]    50.324493: funcgraph_entry:                   |          _raw_spin_unlock() {
           a.out-4609  [003]    50.324494: funcgraph_entry:        0.620 us   |            preempt_count_sub();
           a.out-4609  [003]    50.324495: funcgraph_exit:         1.800 us   |          }
           a.out-4609  [003]    50.324496: funcgraph_exit:       + 11.380 us  |        }
           a.out-4609  [003]    50.324497: funcgraph_exit:       + 12.590 us  |      }
           a.out-4609  [003]    50.324497: funcgraph_entry:                   |      up_read() {
           a.out-4609  [003]    50.324498: funcgraph_entry:        0.620 us   |        preempt_count_add();
           a.out-4609  [003]    50.324499: funcgraph_entry:        0.620 us   |        preempt_count_sub();
           a.out-4609  [003]    50.324500: funcgraph_exit:         3.070 us   |      }
           a.out-4609  [003]    50.324501: funcgraph_entry:        0.610 us   |      fault_in_kernel_space();
           a.out-4609  [003]    50.324503: funcgraph_entry:                   |      lock_mm_and_find_vma() {
           a.out-4609  [003]    50.324503: funcgraph_entry:                   |        down_read_trylock() {
           a.out-4609  [003]    50.324504: funcgraph_entry:        0.610 us   |          preempt_count_add();
           a.out-4609  [003]    50.324505: funcgraph_entry:        0.620 us   |          preempt_count_sub();
           a.out-4609  [003]    50.324506: funcgraph_exit:         3.020 us   |        }
           a.out-4609  [003]    50.324507: funcgraph_entry:        0.610 us   |        __cond_resched();
           a.out-4609  [003]    50.324508: funcgraph_entry:                   |        find_vma() {
           a.out-4609  [003]    50.324509: funcgraph_entry:        0.610 us   |          __rcu_read_lock();
           a.out-4609  [003]    50.324510: funcgraph_entry:        0.620 us   |          __rcu_read_unlock();
           a.out-4609  [003]    50.324511: funcgraph_exit:         3.080 us   |        }
           a.out-4609  [003]    50.324512: funcgraph_exit:         9.030 us   |      }
           a.out-4609  [003]    50.324512: funcgraph_entry:                   |      handle_mm_fault() {
           a.out-4609  [003]    50.324513: funcgraph_entry:                   |        __handle_mm_fault() {
           a.out-4609  [003]    50.324514: funcgraph_entry:                   |          pte_offset_map_nolock() {
           a.out-4609  [003]    50.324514: funcgraph_entry:        0.620 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324515: funcgraph_exit:         1.790 us   |          }
           a.out-4609  [003]    50.324516: funcgraph_entry:                   |          __pte_offset_map_lock() {
           a.out-4609  [003]    50.324517: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324518: funcgraph_entry:                   |            _raw_spin_lock() {
           a.out-4609  [003]    50.324518: funcgraph_entry:        0.620 us   |              preempt_count_add();
           a.out-4609  [003]    50.324520: funcgraph_exit:         1.820 us   |            }
           a.out-4609  [003]    50.324520: funcgraph_exit:         4.180 us   |          }
           a.out-4609  [003]    50.324521: funcgraph_entry:        0.630 us   |          vmf_pte_changed();
           a.out-4609  [003]    50.324522: funcgraph_entry:                   |          _raw_spin_unlock() {
           a.out-4609  [003]    50.324523: funcgraph_entry:        0.620 us   |            preempt_count_sub();
           a.out-4609  [003]    50.324524: funcgraph_exit:         1.800 us   |          }
           a.out-4609  [003]    50.324524: funcgraph_exit:       + 11.370 us  |        }
           a.out-4609  [003]    50.324525: funcgraph_exit:       + 12.580 us  |      }
           a.out-4609  [003]    50.324525: funcgraph_entry:                   |      up_read() {
           a.out-4609  [003]    50.324526: funcgraph_entry:        0.610 us   |        preempt_count_add();
           a.out-4609  [003]    50.324527: funcgraph_entry:        0.620 us   |        preempt_count_sub();
           a.out-4609  [003]    50.324528: funcgraph_exit:         2.990 us   |      }
           a.out-4609  [003]    50.324529: funcgraph_entry:        0.610 us   |      fault_in_kernel_space();
           a.out-4609  [003]    50.324531: funcgraph_entry:                   |      lock_mm_and_find_vma() {
           a.out-4609  [003]    50.324531: funcgraph_entry:                   |        down_read_trylock() {
           a.out-4609  [003]    50.324532: funcgraph_entry:        0.620 us   |          preempt_count_add();
           a.out-4609  [003]    50.324533: funcgraph_entry:        0.620 us   |          preempt_count_sub();
           a.out-4609  [003]    50.324534: funcgraph_exit:         3.080 us   |        }
           a.out-4609  [003]    50.324535: funcgraph_entry:        0.610 us   |        __cond_resched();
           a.out-4609  [003]    50.324536: funcgraph_entry:                   |        find_vma() {
           a.out-4609  [003]    50.324537: funcgraph_entry:        0.610 us   |          __rcu_read_lock();
           a.out-4609  [003]    50.324538: funcgraph_entry:        0.620 us   |          __rcu_read_unlock();
           a.out-4609  [003]    50.324539: funcgraph_exit:         3.080 us   |        }
           a.out-4609  [003]    50.324540: funcgraph_exit:         9.090 us   |      }
           a.out-4609  [003]    50.324540: funcgraph_entry:                   |      handle_mm_fault() {
           a.out-4609  [003]    50.324541: funcgraph_entry:                   |        __handle_mm_fault() {
           a.out-4609  [003]    50.324542: funcgraph_entry:                   |          pte_offset_map_nolock() {
           a.out-4609  [003]    50.324542: funcgraph_entry:        0.620 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324543: funcgraph_exit:         1.800 us   |          }
           a.out-4609  [003]    50.324544: funcgraph_entry:                   |          __pte_offset_map_lock() {
           a.out-4609  [003]    50.324545: funcgraph_entry:        0.620 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324546: funcgraph_entry:                   |            _raw_spin_lock() {
           a.out-4609  [003]    50.324546: funcgraph_entry:        0.620 us   |              preempt_count_add();
           a.out-4609  [003]    50.324548: funcgraph_exit:         1.810 us   |            }
           a.out-4609  [003]    50.324548: funcgraph_exit:         4.200 us   |          }
           a.out-4609  [003]    50.324549: funcgraph_entry:        0.620 us   |          vmf_pte_changed();
           a.out-4609  [003]    50.324550: funcgraph_entry:                   |          _raw_spin_unlock() {
           a.out-4609  [003]    50.324551: funcgraph_entry:        0.620 us   |            preempt_count_sub();
           a.out-4609  [003]    50.324552: funcgraph_exit:         1.790 us   |          }
           a.out-4609  [003]    50.324552: funcgraph_exit:       + 11.380 us  |        }
           a.out-4609  [003]    50.324553: funcgraph_exit:       + 12.580 us  |      }
           a.out-4609  [003]    50.324553: funcgraph_entry:                   |      up_read() {
           a.out-4609  [003]    50.324554: funcgraph_entry:        0.610 us   |        preempt_count_add();
           a.out-4609  [003]    50.324555: funcgraph_entry:        0.630 us   |        preempt_count_sub();
           a.out-4609  [003]    50.324556: funcgraph_exit:         3.010 us   |      }
           a.out-4609  [003]    50.324557: funcgraph_entry:        0.610 us   |      fault_in_kernel_space();
           a.out-4609  [003]    50.324559: funcgraph_entry:                   |      lock_mm_and_find_vma() {
           a.out-4609  [003]    50.324559: funcgraph_entry:                   |        down_read_trylock() {
           a.out-4609  [003]    50.324560: funcgraph_entry:        0.610 us   |          preempt_count_add();
           a.out-4609  [003]    50.324561: funcgraph_entry:        0.620 us   |          preempt_count_sub();
           a.out-4609  [003]    50.324562: funcgraph_exit:         3.020 us   |        }
           a.out-4609  [003]    50.324563: funcgraph_entry:        0.610 us   |        __cond_resched();
           a.out-4609  [003]    50.324564: funcgraph_entry:                   |        find_vma() {
           a.out-4609  [003]    50.324565: funcgraph_entry:        0.620 us   |          __rcu_read_lock();
           a.out-4609  [003]    50.324566: funcgraph_entry:        0.620 us   |          __rcu_read_unlock();
           a.out-4609  [003]    50.324567: funcgraph_exit:         3.070 us   |        }
           a.out-4609  [003]    50.324568: funcgraph_exit:         9.020 us   |      }
           a.out-4609  [003]    50.324568: funcgraph_entry:                   |      handle_mm_fault() {
           a.out-4609  [003]    50.324569: funcgraph_entry:                   |        __handle_mm_fault() {
           a.out-4609  [003]    50.324570: funcgraph_entry:                   |          pte_offset_map_nolock() {
           a.out-4609  [003]    50.324571: funcgraph_entry:        1.360 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324572: funcgraph_exit:         2.550 us   |          }
           a.out-4609  [003]    50.324573: funcgraph_entry:                   |          __pte_offset_map_lock() {
           a.out-4609  [003]    50.324573: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324575: funcgraph_entry:                   |            _raw_spin_lock() {
           a.out-4609  [003]    50.324575: funcgraph_entry:        0.620 us   |              preempt_count_add();
           a.out-4609  [003]    50.324576: funcgraph_exit:         1.820 us   |            }
           a.out-4609  [003]    50.324577: funcgraph_exit:         4.190 us   |          }
           a.out-4609  [003]    50.324578: funcgraph_entry:        0.620 us   |          vmf_pte_changed();
           a.out-4609  [003]    50.324579: funcgraph_entry:                   |          _raw_spin_unlock() {
           a.out-4609  [003]    50.324579: funcgraph_entry:        0.620 us   |            preempt_count_sub();
           a.out-4609  [003]    50.324580: funcgraph_exit:         1.790 us   |          }
           a.out-4609  [003]    50.324581: funcgraph_exit:       + 12.130 us  |        }
           a.out-4609  [003]    50.324582: funcgraph_exit:       + 13.320 us  |      }
           a.out-4609  [003]    50.324582: funcgraph_entry:                   |      up_read() {
           a.out-4609  [003]    50.324583: funcgraph_entry:        0.620 us   |        preempt_count_add();
           a.out-4609  [003]    50.324584: funcgraph_entry:        0.620 us   |        preempt_count_sub();
           a.out-4609  [003]    50.324585: funcgraph_exit:         2.990 us   |      }
           a.out-4609  [003]    50.324586: funcgraph_entry:        0.620 us   |      fault_in_kernel_space();
           a.out-4609  [003]    50.324587: funcgraph_entry:                   |      lock_mm_and_find_vma() {
           a.out-4609  [003]    50.324588: funcgraph_entry:                   |        down_read_trylock() {
           a.out-4609  [003]    50.324589: funcgraph_entry:        0.610 us   |          preempt_count_add();
           a.out-4609  [003]    50.324590: funcgraph_entry:        0.620 us   |          preempt_count_sub();
           a.out-4609  [003]    50.324591: funcgraph_exit:         3.020 us   |        }
           a.out-4609  [003]    50.324592: funcgraph_entry:        0.610 us   |        __cond_resched();
           a.out-4609  [003]    50.324593: funcgraph_entry:                   |        find_vma() {
           a.out-4609  [003]    50.324593: funcgraph_entry:        0.610 us   |          __rcu_read_lock();
           a.out-4609  [003]    50.324595: funcgraph_entry:        0.620 us   |          __rcu_read_unlock();
           a.out-4609  [003]    50.324596: funcgraph_exit:         3.070 us   |        }
           a.out-4609  [003]    50.324596: funcgraph_exit:         9.020 us   |      }
           a.out-4609  [003]    50.324597: funcgraph_entry:                   |      handle_mm_fault() {
           a.out-4609  [003]    50.324598: funcgraph_entry:                   |        __handle_mm_fault() {
           a.out-4609  [003]    50.324598: funcgraph_entry:                   |          pte_offset_map_nolock() {
           a.out-4609  [003]    50.324599: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324600: funcgraph_exit:         1.800 us   |          }
           a.out-4609  [003]    50.324601: funcgraph_entry:                   |          __pte_offset_map_lock() {
           a.out-4609  [003]    50.324601: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324603: funcgraph_entry:                   |            _raw_spin_lock() {
           a.out-4609  [003]    50.324603: funcgraph_entry:        0.610 us   |              preempt_count_add();
           a.out-4609  [003]    50.324604: funcgraph_exit:         1.820 us   |            }
           a.out-4609  [003]    50.324605: funcgraph_exit:         4.180 us   |          }
           a.out-4609  [003]    50.324606: funcgraph_entry:        0.620 us   |          vmf_pte_changed();
           a.out-4609  [003]    50.324607: funcgraph_entry:                   |          _raw_spin_unlock() {
           a.out-4609  [003]    50.324607: funcgraph_entry:        0.620 us   |            preempt_count_sub();
           a.out-4609  [003]    50.324608: funcgraph_exit:         1.800 us   |          }
           a.out-4609  [003]    50.324609: funcgraph_exit:       + 11.380 us  |        }
           a.out-4609  [003]    50.324610: funcgraph_exit:       + 12.580 us  |      }
           a.out-4609  [003]    50.324610: funcgraph_entry:                   |      up_read() {
           a.out-4609  [003]    50.324611: funcgraph_entry:        0.620 us   |        preempt_count_add();
           a.out-4609  [003]    50.324612: funcgraph_entry:        0.630 us   |        preempt_count_sub();
           a.out-4609  [003]    50.324613: funcgraph_exit:         3.000 us   |      }
           a.out-4609  [003]    50.324614: funcgraph_entry:        0.610 us   |      fault_in_kernel_space();
           a.out-4609  [003]    50.324615: funcgraph_entry:                   |      lock_mm_and_find_vma() {
           a.out-4609  [003]    50.324616: funcgraph_entry:                   |        down_read_trylock() {
           a.out-4609  [003]    50.324617: funcgraph_entry:        0.620 us   |          preempt_count_add();
           a.out-4609  [003]    50.324618: funcgraph_entry:        0.620 us   |          preempt_count_sub();
           a.out-4609  [003]    50.324619: funcgraph_exit:         3.020 us   |        }
           a.out-4609  [003]    50.324620: funcgraph_entry:        0.610 us   |        __cond_resched();
           a.out-4609  [003]    50.324621: funcgraph_entry:                   |        find_vma() {
           a.out-4609  [003]    50.324621: funcgraph_entry:        0.610 us   |          __rcu_read_lock();
           a.out-4609  [003]    50.324623: funcgraph_entry:        0.620 us   |          __rcu_read_unlock();
           a.out-4609  [003]    50.324624: funcgraph_exit:         3.070 us   |        }
           a.out-4609  [003]    50.324624: funcgraph_exit:         9.020 us   |      }
           a.out-4609  [003]    50.324625: funcgraph_entry:                   |      handle_mm_fault() {
           a.out-4609  [003]    50.324626: funcgraph_entry:                   |        __handle_mm_fault() {
           a.out-4609  [003]    50.324626: funcgraph_entry:                   |          pte_offset_map_nolock() {
           a.out-4609  [003]    50.324627: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324628: funcgraph_exit:         1.800 us   |          }
           a.out-4609  [003]    50.324629: funcgraph_entry:                   |          __pte_offset_map_lock() {
           a.out-4609  [003]    50.324629: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324631: funcgraph_entry:                   |            _raw_spin_lock() {
           a.out-4609  [003]    50.324631: funcgraph_entry:        0.620 us   |              preempt_count_add();
           a.out-4609  [003]    50.324632: funcgraph_exit:         1.810 us   |            }
           a.out-4609  [003]    50.324633: funcgraph_exit:         4.190 us   |          }
           a.out-4609  [003]    50.324634: funcgraph_entry:        0.630 us   |          vmf_pte_changed();
           a.out-4609  [003]    50.324635: funcgraph_entry:                   |          _raw_spin_unlock() {
           a.out-4609  [003]    50.324635: funcgraph_entry:        0.610 us   |            preempt_count_sub();
           a.out-4609  [003]    50.324636: funcgraph_exit:         1.790 us   |          }
           a.out-4609  [003]    50.324637: funcgraph_exit:       + 11.380 us  |        }
           a.out-4609  [003]    50.324638: funcgraph_exit:       + 12.570 us  |      }
           a.out-4609  [003]    50.324638: funcgraph_entry:                   |      up_read() {
           a.out-4609  [003]    50.324639: funcgraph_entry:        0.610 us   |        preempt_count_add();
           a.out-4609  [003]    50.324640: funcgraph_entry:        0.620 us   |        preempt_count_sub();
           a.out-4609  [003]    50.324641: funcgraph_exit:         3.000 us   |      }
           a.out-4609  [003]    50.324642: funcgraph_entry:        0.620 us   |      fault_in_kernel_space();
           a.out-4609  [003]    50.324644: funcgraph_entry:                   |      lock_mm_and_find_vma() {
           a.out-4609  [003]    50.324645: funcgraph_entry:                   |        down_read_trylock() {
           a.out-4609  [003]    50.324645: funcgraph_entry:        0.690 us   |          preempt_count_add();
           a.out-4609  [003]    50.324647: funcgraph_entry:        0.630 us   |          preempt_count_sub();
           a.out-4609  [003]    50.324648: funcgraph_exit:         3.120 us   |        }
           a.out-4609  [003]    50.324648: funcgraph_entry:        0.610 us   |        __cond_resched();
           a.out-4609  [003]    50.324650: funcgraph_entry:                   |        find_vma() {
           a.out-4609  [003]    50.324650: funcgraph_entry:        0.610 us   |          __rcu_read_lock();
           a.out-4609  [003]    50.324651: funcgraph_entry:        0.620 us   |          __rcu_read_unlock();
           a.out-4609  [003]    50.324653: funcgraph_exit:         3.090 us   |        }
           a.out-4609  [003]    50.324653: funcgraph_exit:         9.700 us   |      }
           a.out-4609  [003]    50.324654: funcgraph_entry:                   |      handle_mm_fault() {
           a.out-4609  [003]    50.324654: funcgraph_entry:                   |        __handle_mm_fault() {
           a.out-4609  [003]    50.324655: funcgraph_entry:                   |          pte_offset_map_nolock() {
           a.out-4609  [003]    50.324656: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324657: funcgraph_exit:         1.810 us   |          }
           a.out-4609  [003]    50.324657: funcgraph_entry:                   |          __pte_offset_map_lock() {
           a.out-4609  [003]    50.324658: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324659: funcgraph_entry:                   |            _raw_spin_lock() {
           a.out-4609  [003]    50.324660: funcgraph_entry:        0.620 us   |              preempt_count_add();
           a.out-4609  [003]    50.324661: funcgraph_exit:         1.820 us   |            }
           a.out-4609  [003]    50.324662: funcgraph_exit:         4.190 us   |          }
           a.out-4609  [003]    50.324662: funcgraph_entry:        0.620 us   |          vmf_pte_changed();
           a.out-4609  [003]    50.324663: funcgraph_entry:                   |          _raw_spin_unlock() {
           a.out-4609  [003]    50.324664: funcgraph_entry:        0.620 us   |            preempt_count_sub();
           a.out-4609  [003]    50.324665: funcgraph_exit:         1.800 us   |          }
           a.out-4609  [003]    50.324666: funcgraph_exit:       + 11.410 us  |        }
           a.out-4609  [003]    50.324666: funcgraph_exit:       + 12.620 us  |      }
           a.out-4609  [003]    50.324667: funcgraph_entry:                   |      up_read() {
           a.out-4609  [003]    50.324668: funcgraph_entry:        0.620 us   |        preempt_count_add();
           a.out-4609  [003]    50.324669: funcgraph_entry:        0.620 us   |        preempt_count_sub();
           a.out-4609  [003]    50.324670: funcgraph_exit:         3.000 us   |      }
           a.out-4609  [003]    50.324671: funcgraph_entry:        0.620 us   |      fault_in_kernel_space();
           a.out-4609  [003]    50.324672: funcgraph_entry:                   |      lock_mm_and_find_vma() {
           a.out-4609  [003]    50.324673: funcgraph_entry:                   |        down_read_trylock() {
           a.out-4609  [003]    50.324673: funcgraph_entry:        0.610 us   |          preempt_count_add();
           a.out-4609  [003]    50.324675: funcgraph_entry:        0.620 us   |          preempt_count_sub();
           a.out-4609  [003]    50.324676: funcgraph_exit:         3.030 us   |        }
           a.out-4609  [003]    50.324676: funcgraph_entry:        0.610 us   |        __cond_resched();
           a.out-4609  [003]    50.324678: funcgraph_entry:                   |        find_vma() {
           a.out-4609  [003]    50.324678: funcgraph_entry:        0.620 us   |          __rcu_read_lock();
           a.out-4609  [003]    50.324679: funcgraph_entry:        0.620 us   |          __rcu_read_unlock();
           a.out-4609  [003]    50.324681: funcgraph_exit:         3.080 us   |        }
           a.out-4609  [003]    50.324681: funcgraph_exit:         9.040 us   |      }
           a.out-4609  [003]    50.324682: funcgraph_entry:                   |      handle_mm_fault() {
           a.out-4609  [003]    50.324682: funcgraph_entry:                   |        __handle_mm_fault() {
           a.out-4609  [003]    50.324683: funcgraph_entry:                   |          pte_offset_map_nolock() {
           a.out-4609  [003]    50.324684: funcgraph_entry:        0.620 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324685: funcgraph_exit:         1.800 us   |          }
           a.out-4609  [003]    50.324686: funcgraph_entry:                   |          __pte_offset_map_lock() {
           a.out-4609  [003]    50.324686: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324687: funcgraph_entry:                   |            _raw_spin_lock() {
           a.out-4609  [003]    50.324688: funcgraph_entry:        0.620 us   |              preempt_count_add();
           a.out-4609  [003]    50.324689: funcgraph_exit:         1.820 us   |            }
           a.out-4609  [003]    50.324690: funcgraph_exit:         4.190 us   |          }
           a.out-4609  [003]    50.324690: funcgraph_entry:        0.630 us   |          vmf_pte_changed();
           a.out-4609  [003]    50.324692: funcgraph_entry:                   |          _raw_spin_unlock() {
           a.out-4609  [003]    50.324692: funcgraph_entry:        0.610 us   |            preempt_count_sub();
           a.out-4609  [003]    50.324693: funcgraph_exit:         1.790 us   |          }
           a.out-4609  [003]    50.324694: funcgraph_exit:       + 11.430 us  |        }
           a.out-4609  [003]    50.324694: funcgraph_exit:       + 12.630 us  |      }
           a.out-4609  [003]    50.324695: funcgraph_entry:                   |      up_read() {
           a.out-4609  [003]    50.324696: funcgraph_entry:        0.610 us   |        preempt_count_add();
           a.out-4609  [003]    50.324697: funcgraph_entry:        0.620 us   |        preempt_count_sub();
           a.out-4609  [003]    50.324698: funcgraph_exit:         3.000 us   |      }
           a.out-4609  [003]    50.324699: funcgraph_entry:        0.610 us   |      fault_in_kernel_space();
           a.out-4609  [003]    50.324700: funcgraph_entry:                   |      lock_mm_and_find_vma() {
           a.out-4609  [003]    50.324701: funcgraph_entry:                   |        down_read_trylock() {
           a.out-4609  [003]    50.324702: funcgraph_entry:        0.620 us   |          preempt_count_add();
           a.out-4609  [003]    50.324703: funcgraph_entry:        0.620 us   |          preempt_count_sub();
           a.out-4609  [003]    50.324704: funcgraph_exit:         3.020 us   |        }
           a.out-4609  [003]    50.324705: funcgraph_entry:        0.610 us   |        __cond_resched();
           a.out-4609  [003]    50.324706: funcgraph_entry:                   |        find_vma() {
           a.out-4609  [003]    50.324706: funcgraph_entry:        0.610 us   |          __rcu_read_lock();
           a.out-4609  [003]    50.324708: funcgraph_entry:        0.620 us   |          __rcu_read_unlock();
           a.out-4609  [003]    50.324709: funcgraph_exit:         3.070 us   |        }
           a.out-4609  [003]    50.324709: funcgraph_exit:         9.020 us   |      }
           a.out-4609  [003]    50.324710: funcgraph_entry:                   |      handle_mm_fault() {
           a.out-4609  [003]    50.324711: funcgraph_entry:                   |        __handle_mm_fault() {
           a.out-4609  [003]    50.324711: funcgraph_entry:                   |          pte_offset_map_nolock() {
           a.out-4609  [003]    50.324712: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324713: funcgraph_exit:         1.800 us   |          }
           a.out-4609  [003]    50.324714: funcgraph_entry:                   |          __pte_offset_map_lock() {
           a.out-4609  [003]    50.324714: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324715: funcgraph_entry:                   |            _raw_spin_lock() {
           a.out-4609  [003]    50.324716: funcgraph_entry:        0.620 us   |              preempt_count_add();
           a.out-4609  [003]    50.324718: funcgraph_exit:         1.820 us   |            }
           a.out-4609  [003]    50.324718: funcgraph_exit:         4.710 us   |          }
           a.out-4609  [003]    50.324719: funcgraph_entry:        0.630 us   |          vmf_pte_changed();
           a.out-4609  [003]    50.324720: funcgraph_entry:                   |          _raw_spin_unlock() {
           a.out-4609  [003]    50.324721: funcgraph_entry:        0.620 us   |            preempt_count_sub();
           a.out-4609  [003]    50.324722: funcgraph_exit:         1.800 us   |          }
           a.out-4609  [003]    50.324722: funcgraph_exit:       + 11.960 us  |        }
           a.out-4609  [003]    50.324723: funcgraph_exit:       + 13.170 us  |      }
           a.out-4609  [003]    50.324724: funcgraph_entry:                   |      up_read() {
           a.out-4609  [003]    50.324724: funcgraph_entry:        0.610 us   |        preempt_count_add();
           a.out-4609  [003]    50.324725: funcgraph_entry:        0.620 us   |        preempt_count_sub();
           a.out-4609  [003]    50.324727: funcgraph_exit:         3.000 us   |      }
           a.out-4609  [003]    50.324728: funcgraph_entry:        0.610 us   |      fault_in_kernel_space();
           a.out-4609  [003]    50.324729: funcgraph_entry:                   |      lock_mm_and_find_vma() {
           a.out-4609  [003]    50.324730: funcgraph_entry:                   |        down_read_trylock() {
           a.out-4609  [003]    50.324730: funcgraph_entry:        0.610 us   |          preempt_count_add();
           a.out-4609  [003]    50.324732: funcgraph_entry:        0.630 us   |          preempt_count_sub();
           a.out-4609  [003]    50.324733: funcgraph_exit:         3.030 us   |        }
           a.out-4609  [003]    50.324733: funcgraph_entry:        0.610 us   |        __cond_resched();
           a.out-4609  [003]    50.324735: funcgraph_entry:                   |        find_vma() {
           a.out-4609  [003]    50.324735: funcgraph_entry:        0.610 us   |          __rcu_read_lock();
           a.out-4609  [003]    50.324736: funcgraph_entry:        0.620 us   |          __rcu_read_unlock();
           a.out-4609  [003]    50.324738: funcgraph_exit:         3.080 us   |        }
           a.out-4609  [003]    50.324738: funcgraph_exit:         9.040 us   |      }
           a.out-4609  [003]    50.324739: funcgraph_entry:                   |      handle_mm_fault() {
           a.out-4609  [003]    50.324739: funcgraph_entry:                   |        __handle_mm_fault() {
           a.out-4609  [003]    50.324740: funcgraph_entry:                   |          pte_offset_map_nolock() {
           a.out-4609  [003]    50.324741: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324742: funcgraph_exit:         1.800 us   |          }
           a.out-4609  [003]    50.324742: funcgraph_entry:                   |          __pte_offset_map_lock() {
           a.out-4609  [003]    50.324743: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324744: funcgraph_entry:                   |            _raw_spin_lock() {
           a.out-4609  [003]    50.324745: funcgraph_entry:        0.620 us   |              preempt_count_add();
           a.out-4609  [003]    50.324746: funcgraph_exit:         1.820 us   |            }
           a.out-4609  [003]    50.324747: funcgraph_exit:         4.190 us   |          }
           a.out-4609  [003]    50.324747: funcgraph_entry:        0.630 us   |          vmf_pte_changed();
           a.out-4609  [003]    50.324748: funcgraph_entry:                   |          _raw_spin_unlock() {
           a.out-4609  [003]    50.324749: funcgraph_entry:        0.620 us   |            preempt_count_sub();
           a.out-4609  [003]    50.324750: funcgraph_exit:         1.800 us   |          }
           a.out-4609  [003]    50.324751: funcgraph_exit:       + 11.410 us  |        }
           a.out-4609  [003]    50.324751: funcgraph_exit:       + 12.610 us  |      }
           a.out-4609  [003]    50.324752: funcgraph_entry:                   |      up_read() {
           a.out-4609  [003]    50.324753: funcgraph_entry:        0.610 us   |        preempt_count_add();
           a.out-4609  [003]    50.324754: funcgraph_entry:        0.620 us   |        preempt_count_sub();
           a.out-4609  [003]    50.324755: funcgraph_exit:         2.990 us   |      }
           a.out-4609  [003]    50.324756: funcgraph_entry:        0.620 us   |      fault_in_kernel_space();
           a.out-4609  [003]    50.324757: funcgraph_entry:                   |      lock_mm_and_find_vma() {
           a.out-4609  [003]    50.324758: funcgraph_entry:                   |        down_read_trylock() {
           a.out-4609  [003]    50.324758: funcgraph_entry:        0.620 us   |          preempt_count_add();
           a.out-4609  [003]    50.324760: funcgraph_entry:        0.620 us   |          preempt_count_sub();
           a.out-4609  [003]    50.324761: funcgraph_exit:         3.010 us   |        }
           a.out-4609  [003]    50.324761: funcgraph_entry:        0.610 us   |        __cond_resched();
           a.out-4609  [003]    50.324763: funcgraph_entry:                   |        find_vma() {
           a.out-4609  [003]    50.324763: funcgraph_entry:        0.610 us   |          __rcu_read_lock();
           a.out-4609  [003]    50.324764: funcgraph_entry:        0.620 us   |          __rcu_read_unlock();
           a.out-4609  [003]    50.324766: funcgraph_exit:         3.080 us   |        }
           a.out-4609  [003]    50.324766: funcgraph_exit:         9.020 us   |      }
           a.out-4609  [003]    50.324767: funcgraph_entry:                   |      handle_mm_fault() {
           a.out-4609  [003]    50.324767: funcgraph_entry:                   |        __handle_mm_fault() {
           a.out-4609  [003]    50.324768: funcgraph_entry:                   |          pte_offset_map_nolock() {
           a.out-4609  [003]    50.324769: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324770: funcgraph_exit:         1.800 us   |          }
           a.out-4609  [003]    50.324770: funcgraph_entry:                   |          __pte_offset_map_lock() {
           a.out-4609  [003]    50.324771: funcgraph_entry:        0.610 us   |            __pte_offset_map();
           a.out-4609  [003]    50.324772: funcgraph_entry:                   |            _raw_spin_lock() {
           a.out-4609  [003]    50.324773: funcgraph_entry:        0.610 us   |              preempt_count_add();
           a.out-4609  [003]    50.324774: funcgraph_exit:         1.810 us   |            }
           a.out-4609  [003]    50.324775: funcgraph_exit:         4.180 us   |          }
           a.out-4609  [003]    50.324775: funcgraph_entry:        0.620 us   |          vmf_pte_changed();
           a.out-4609  [003]    50.324776: funcgraph_entry:                   |          _raw_spin_unlock() {
           a.out-4609  [003]    50.324777: funcgraph_entry:        0.620 us   |            preempt_count_sub();
           a.out-4609  [003]    50.324778: funcgraph_exit:         1.790 us   |          }
           a.out-4609  [003]    50.324779: funcgraph_exit:       + 11.370 us  |        }
           a.out-4609  [003]    50.324779: funcgraph_exit:       + 12.560 us  |      }
           a.out-4609  [003]    50.324780: funcgraph_entry:                   |      up_read() {
           a.out-4609  [003]    50.324780: funcgraph_entry:        0.610 us   |        preempt_count_add();
           a.out-4609  [003]    50.324782: funcgraph_entry:        0.620 us   |        preempt_count_sub();
           a.out-4609  [003]    50.324783: funcgraph_exit:         3.000 us   |      }
           a.out-4609  [003]    50.324784: funcgraph_exit:       ! 622.580 us |    }
           a.out-4609  [003]    50.324785: funcgraph_entry:        0.720 us   |    eth_type_trans();
           a.out-4609  [003]    50.324786: funcgraph_entry:                   |    __skb_flow_dissect() {
           a.out-4609  [003]    50.324787: funcgraph_entry:        0.620 us   |      __rcu_read_lock();
           a.out-4609  [003]    50.324788: funcgraph_entry:        0.620 us   |      __rcu_read_unlock();
           a.out-4609  [003]    50.324790: funcgraph_exit:         4.340 us   |    }
           a.out-4609  [003]    50.324791: funcgraph_entry:        0.640 us   |    __local_bh_disable_ip();
           a.out-4609  [003]    50.324793: funcgraph_entry:        0.660 us   |    __rcu_read_lock();
           a.out-4609  [003]    50.324794: funcgraph_entry:                   |    do_xdp_generic() {
           a.out-4609  [003]    50.324795: funcgraph_entry:                   |      pskb_expand_head() {
           a.out-4609  [003]    50.324796: funcgraph_entry:                   |        kmalloc_reserve() {
           a.out-4609  [003]    50.324796: funcgraph_entry:        0.610 us   |          kmalloc_size_roundup();
           a.out-4609  [003]    50.324797: funcgraph_entry:                   |          __kmalloc_node_track_caller() {
           a.out-4609  [003]    50.324798: funcgraph_entry:                   |            __kmalloc_large_node() {
           a.out-4609  [003]    50.324799: funcgraph_entry:                   |              __alloc_pages() {
           a.out-4609  [003]    50.324799: funcgraph_entry:        0.600 us   |                should_fail_alloc_page();
           a.out-4609  [003]    50.324800: funcgraph_entry:                   |                get_page_from_freelist() {
           a.out-4609  [003]    50.324801: funcgraph_entry:        0.640 us   |                  __zone_watermark_ok();
           a.out-4609  [003]    50.324802: funcgraph_entry:                   |                  _raw_spin_lock_irqsave() {
           a.out-4609  [003]    50.324803: funcgraph_entry:        0.600 us   |                    preempt_count_add();
           a.out-4609  [003]    50.324804: funcgraph_exit:         1.810 us   |                  }
           a.out-4609  [003]    50.324805: funcgraph_entry:        0.620 us   |                  __mod_zone_page_state();
           a.out-4609  [003]    50.324806: funcgraph_entry:                   |                  _raw_spin_unlock_irqrestore() {
           a.out-4609  [003]    50.324807: funcgraph_entry:        0.610 us   |                    preempt_count_sub();
           a.out-4609  [003]    50.324808: funcgraph_exit:         1.800 us   |                  }
           a.out-4609  [003]    50.324809: funcgraph_entry:                   |                  prep_new_page() {
           a.out-4609  [003]    50.324811: funcgraph_entry:        1.040 us   |                    prep_compound_page();
           a.out-4609  [003]    50.324812: funcgraph_exit:         3.560 us   |                  }
           a.out-4609  [003]    50.324813: funcgraph_exit:       + 12.300 us  |                }
           a.out-4609  [003]    50.324813: funcgraph_exit:       + 14.700 us  |              }
           a.out-4609  [003]    50.324814: funcgraph_entry:        0.640 us   |              mod_node_page_state();
           a.out-4609  [003]    50.324815: funcgraph_exit:       + 17.120 us  |            }
           a.out-4609  [003]    50.324816: funcgraph_exit:       + 18.310 us  |          }
           a.out-4609  [003]    50.324816: funcgraph_exit:       + 20.700 us  |        }
           a.out-4609  [003]    50.324822: funcgraph_entry:                   |        skb_free_head() {
           a.out-4609  [003]    50.324822: funcgraph_entry:                   |          skb_kfree_head() {
           a.out-4609  [003]    50.324823: funcgraph_entry:                   |            kfree() {
           a.out-4609  [003]    50.324824: funcgraph_entry:                   |              free_large_kmalloc() {
           a.out-4609  [003]    50.324824: funcgraph_entry:        0.620 us   |                mod_node_page_state();
           a.out-4609  [003]    50.324825: funcgraph_entry:                   |                __free_pages() {
           a.out-4609  [003]    50.324826: funcgraph_entry:                   |                  __free_pages_ok() {
           a.out-4609  [003]    50.324827: funcgraph_entry:        0.620 us   |                    free_tail_page_prepare();
           a.out-4609  [003]    50.324828: funcgraph_entry:        0.610 us   |                    free_tail_page_prepare();
           a.out-4609  [003]    50.324829: funcgraph_entry:        0.610 us   |                    free_tail_page_prepare();
           a.out-4609  [003]    50.324830: funcgraph_entry:        0.620 us   |                    free_tail_page_prepare();
           a.out-4609  [003]    50.324832: funcgraph_entry:        0.620 us   |                    free_tail_page_prepare();
           a.out-4609  [003]    50.324833: funcgraph_entry:        0.610 us   |                    free_tail_page_prepare();
           a.out-4609  [003]    50.324834: funcgraph_entry:        0.610 us   |                    free_tail_page_prepare();
           a.out-4609  [003]    50.324835: funcgraph_entry:        0.620 us   |                    free_tail_page_prepare();
           a.out-4609  [003]    50.324836: funcgraph_entry:        0.620 us   |                    free_tail_page_prepare();
           a.out-4609  [003]    50.324838: funcgraph_entry:        0.610 us   |                    free_tail_page_prepare();
           a.out-4609  [003]    50.324839: funcgraph_entry:        0.610 us   |                    free_tail_page_prepare();
           a.out-4609  [003]    50.324840: funcgraph_entry:        0.620 us   |                    free_tail_page_prepare();
           a.out-4609  [003]    50.324841: funcgraph_entry:        0.620 us   |                    free_tail_page_prepare();
           a.out-4609  [003]    50.324842: funcgraph_entry:        0.610 us   |                    free_tail_page_prepare();
           a.out-4609  [003]    50.324844: funcgraph_entry:        0.610 us   |                    free_tail_page_prepare();
           a.out-4609  [003]    50.324845: funcgraph_entry:                   |                    _raw_spin_lock_irqsave() {
           a.out-4609  [003]    50.324846: funcgraph_entry:        0.600 us   |                      preempt_count_add();
           a.out-4609  [003]    50.324847: funcgraph_exit:         1.820 us   |                    }
           a.out-4609  [003]    50.324847: funcgraph_entry:        0.610 us   |                    __mod_zone_page_state();
           a.out-4609  [003]    50.324849: funcgraph_entry:                   |                    _raw_spin_unlock_irqrestore() {
           a.out-4609  [003]    50.324850: funcgraph_entry:        0.610 us   |                      preempt_count_sub();
           a.out-4609  [003]    50.324851: funcgraph_exit:         1.790 us   |                    }
           a.out-4609  [003]    50.324851: funcgraph_exit:       + 25.120 us  |                  }
           a.out-4609  [003]    50.324852: funcgraph_exit:       + 26.370 us  |                }
           a.out-4609  [003]    50.324852: funcgraph_exit:       + 28.790 us  |              }
           a.out-4609  [003]    50.324853: funcgraph_exit:       + 29.990 us  |            }
           a.out-4609  [003]    50.324853: funcgraph_exit:       + 31.180 us  |          }
           a.out-4609  [003]    50.324854: funcgraph_exit:       + 32.460 us  |        }
           a.out-4609  [003]    50.324855: funcgraph_entry:        0.660 us   |        skb_headers_offset_update();
           a.out-4609  [003]    50.324856: funcgraph_exit:       + 61.220 us  |      }
           a.out-4609  [003]    50.324857: funcgraph_entry:                   |      bpf_prog_run_generic_xdp() {
           a.out-4609  [003]    50.324858: funcgraph_entry:                   |        __bpf_prog_run32() {
           a.out-4609  [003]    50.324858: funcgraph_entry:                   |          ___bpf_prog_run() {
           a.out-4609  [003]    50.324859: funcgraph_entry:                   |            bpf_xdp_adjust_tail() {
           a.out-4609  [003]    50.324860: funcgraph_entry:                   |              __warn_printk() {
           a.out-4609  [003]    50.324861: funcgraph_entry:                   |                _printk() {
[truncated some long traces for printk]

--GHBU06YYG/OowSDC--
